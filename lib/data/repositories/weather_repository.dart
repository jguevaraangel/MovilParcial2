import 'package:loggy/loggy.dart';
import 'package:movil_parcial2/data/local/weather_local_datasource.dart';
import 'package:movil_parcial2/data/model/weather_model.dart';
import 'package:movil_parcial2/data/model/weatherfavorite_model.dart';
import 'package:movil_parcial2/data/remote/weather_repository_remote.dart';

class WeatherRepository {
  late WeatherRepositoryRemote remoteDataSource;
  late WeatherRepositoryLocal localDataSource;

  WeatherRepository() {
    logInfo("Starting UserRepository");
    remoteDataSource = WeatherRepositoryRemote();
    localDataSource = WeatherRepositoryLocal();
  }

  Future<WeatherInfoModel> getWeatherInfo(int cityId) async {
    return getWeatherInfo(cityId); // wrap check for exists do everytrhing xd
  }

  Future<List<WeatherFavoriteModel>> getFavorites() async =>
      await localDataSource.getFavorites();

  Future<void> addFavoriteCity(int cityId) async =>
      await localDataSource.addFavoriteCity(cityId);

  Future<void> deleteFavoriteCity(int cityId) async =>
      await localDataSource.deleteFavoriteCity(cityId);
}
