import 'package:movil_parcial2/data/model/weather_model.dart';
import 'package:movil_parcial2/data/model/weatherdb_model.dart';
import 'package:hive/hive.dart';
import 'package:movil_parcial2/data/model/weatherfavorite_model.dart';
import 'package:movil_parcial2/data/model/weatherfavoritedb_model.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:movil_parcial2/common/constants.dart';

class WeatherRepositoryLocal {
  addWeatherInfo(int cityId, WeatherInfoModel info) async {
    await Hive.box('weatherinfo').put(
        cityId,
        WeatherInfoDB(
          description: info.description,
          icon: info.icon,
          mainTitle: info.mainTitle,
          temp: info.temp,
          feelsLike: info.feelsLike,
          pressure: info.pressure,
          humidity: info.humidity,
          windSpeed: info.windSpeed,
          cityId: info.cityId,
          city: info.city,
        ));
  }

  Future<WeatherInfoModel> getWeatherInfo(int cityId) async {
    WeatherInfoDB info = await Hive.box("weatherinfo").get(cityId);
    return WeatherInfoModel(
      description: info.description,
      icon: info.icon,
      mainTitle: info.mainTitle,
      temp: info.temp,
      feelsLike: info.feelsLike,
      pressure: info.pressure,
      humidity: info.humidity,
      windSpeed: info.windSpeed,
      cityId: info.cityId,
      city: info.city,
    );
  }

  addFavoriteCity(int cityId) async {
    WeatherInfoModel x = await getWeatherInfo(cityId);
    await Hive.box('favorites').add(WeatherFavoriteDB(
      cityId: cityId,
      city: x.city,
    ));
  }

  Future<List<WeatherFavoriteModel>> getFavorites() async {
    return Hive.box('favorites').values.map<WeatherFavoriteModel>((e) {
      return WeatherFavoriteModel(
        id: e.key,
        city: e.city,
        cityId: e.cityId,
      );
    }).toList();
  }

  deleteFavoriteCity(int cityId) async {
    Hive.box('favorites').deleteAt(cityId);
  }

  Future<int> getCityKey(int geoID) async {
    var box = Hive.box("geo2city");
    if (!box.containsKey(geoID)) {
      return -1;
    } else {
      return box.get(geoID);
    }
  }

  addCityKey(int geoID, int cityID) async {
    await Hive.box("geo2city").put(geoID, cityID);
  }

  /*
    0 is Index
    1 is GeoID
    2 is Name
    3 is Country CODE
    4 is Province/State
    */
  Future<List<String>> getCityNames() async {
    String wholeCSV = await rootBundle.loadString("lib/common/cities.csv");
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(wholeCSV);

    return rowsAsListOfValues.map((e) {
      return "${e[2]}, ${countryCodeToName[e[3]]}";
    }).toList();
  }

  Future<List<int>> getCityCodes() async {
    String wholeCSV = await rootBundle.loadString("lib/common/cities.csv");
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(wholeCSV);

    return rowsAsListOfValues.map((e) {
      return e[1] as int;
    }).toList();
  }
}
