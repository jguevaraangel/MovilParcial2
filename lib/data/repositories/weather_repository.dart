import 'package:loggy/loggy.dart';
import 'package:movil_parcial2/data/local/weather_local_datasource.dart';
import 'package:movil_parcial2/data/model/weather_model.dart';
import 'package:movil_parcial2/data/model/weatherfavorite_model.dart';
import 'package:movil_parcial2/data/remote/weather_repository_remote.dart';

class WeatherRepository {
  late WeatherRepositoryRemote remoteDataSource;
  late WeatherRepositoryLocal localDataSource;

  late List<String> cityNames;
  late List<int> cityCodes;

  static const int SecondsTillInfoExpiration = 60; // weather expires after a 1m
  // 60 * 60; // weather expires after 1h

  WeatherRepository() {
    logInfo("Creating Weather Repository");
    remoteDataSource = WeatherRepositoryRemote();
    localDataSource = WeatherRepositoryLocal();
  }

  Future<void> initializeData() async {
    logInfo("Initializing Weather Data");
    cityNames = await localDataSource.getCityNames();
    cityCodes = await localDataSource.getCityCodes();
  }

  Future<WeatherInfoModel> _addWeatherInfoCity(
      String cityname, int geoID) async {
    WeatherInfoModel ret = await remoteDataSource
        .getWeatherInfo(cityname)
        .then((WeatherInfoModel newInfo) async {
      // add to Database if fetched Sucessfully.
      await localDataSource.addCityKey(geoID, newInfo.cityId);
      logInfo("Added New City key! ${newInfo.cityId}");
      await localDataSource.addWeatherInfo(newInfo.cityId, newInfo);
      logInfo("Added New Local Weather Info");
      return newInfo;
    }).catchError((error) => Future.error("Couldn't Add new City to DB $error")
            as Future<WeatherInfoModel>); // return error
    return ret;
  }

  Future<WeatherInfoModel> _updateWeatherInfoByCityID(int cityID) async {
    WeatherInfoModel ret = await remoteDataSource
        .getWeatherInfoByCityID(cityID)
        .then((WeatherInfoModel newInfo) async {
      // Update Database if fetched Sucessfully.
      await localDataSource.addWeatherInfo(newInfo.cityId, newInfo);
      logInfo("Updated Local DataSource for city with ID $cityID");
      return newInfo;
    }).catchError((error) => Future.error("Couldn't Update City to DB $error")
            as Future<WeatherInfoModel>); // return error
    return ret;
  }

  Future<WeatherInfoModel> getWeatherInfo(String cityName, int geoID) async {
    // IF cityKey is in geoID database, THEN CITY MUST BE IN WHOLE DATABASE.
    // Verify if geoID is in local database.
    logInfo("Requesting Weather Info: $cityName & geoID = $geoID");
    int cityKey = await localDataSource.getCityKey(geoID);
    if (cityKey == -1) {
      logInfo("geoID: $geoID not found in local! Requesting from Remote");
      // Not in local database, fetch and Add.
      return await _addWeatherInfoCity(cityName, geoID);
    } else {
      // In Local Database, so just get from city, and check if exists.
      logInfo("geoID: $geoID found in local, associated cityID $cityKey");
      return await getWeatherInfoByCityID(cityKey);
    }
  }

  Future<WeatherInfoModel> getWeatherInfoByCityID(int cityID) async {
    // IT SHOULD BE in database. Although, who knows, it might not.
    if (!await localDataSource.checkLocalCityKey(cityID)) {
      logWarning("Previous city key in database without Weather Data!");
      return await _updateWeatherInfoByCityID(
          cityID); // update it if for some reason it's not there.
    }
    WeatherInfoModel currentInfo = await localDataSource.getWeatherInfo(cityID);
    logInfo("Fetched Local Info, with timestamp ${currentInfo.unixTimestamp}");
    int currEpochSeconds =
        (DateTime.now().millisecondsSinceEpoch / 1000).round();

    logDebug("Current Epoch Seconds: $currEpochSeconds");
    if (currEpochSeconds < // Has NOT expired.
        currentInfo.unixTimestamp + SecondsTillInfoExpiration) {
      logInfo("Local Info is Valid. Has not Expired!");
      return currentInfo; // information is still valid.
    } else {
      // Update Information
      logInfo("Local Info is Invalid. It has expired!. Requesting new one...");
      return await _updateWeatherInfoByCityID(cityID);
    }
  }

  Future<List<WeatherFavoriteModel>> getFavorites() async =>
      await localDataSource.getFavorites();

  Future<void> addFavoriteCity(int cityId) async =>
      await localDataSource.addFavoriteCity(cityId);

  Future<void> deleteFavoriteCity(int cityId) async =>
      await localDataSource.deleteFavoriteCity(cityId);

  List<String> getCityNames() => cityNames;

  List<int> getCityCodes() => cityCodes;
}
