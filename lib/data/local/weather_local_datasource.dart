import 'package:movil_parcial2/data/model/weather_model.dart';
import 'package:movil_parcial2/data/model/weatherdb_model.dart';
import 'package:hive/hive.dart';
import 'package:movil_parcial2/data/model/weatherfavorite_model.dart';
import 'package:movil_parcial2/data/model/weatherfavoritedb_model.dart';

class WeatherRepositoryLocal {
  addWeatherInfo(int cityId, WeatherInfoDB info) {
    Hive.box('weatherinfo').put(
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

  WeatherInfoModel getWeatherInfo(int cityId) {
    WeatherInfoDB info = Hive.box("weatherinfo").get(cityId);
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

  addFavoriteCity(int cityId) {
    Hive.box('favorites').add(WeatherFavoriteDB(
      cityId: cityId,
      city: getWeatherInfo(cityId).city,
    ));
  }

  List<WeatherFavoriteModel> getAllUsers() {
    return Hive.box('users').values.map<WeatherFavoriteModel>((e) {
      return WeatherFavoriteModel(
        id: e.key,
        city: e.country,
        cityId: e.gender,
      );
    }).toList();
  }

  addFavoriteCity(int cityId) {
    Hive.box('favorites').add(WeatherFavoriteDB(
      cityId: cityId,
      city: getWeatherInfo(cityId).city,
    ));
  }
}
