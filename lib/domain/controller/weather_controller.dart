import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
// import 'package:flutter/material.dart';
import 'package:movil_parcial2/data/model/weather_model.dart';
import 'package:movil_parcial2/data/model/weatherfavorite_model.dart';
import 'package:movil_parcial2/data/repositories/weather_repository.dart';
import 'package:movil_parcial2/ui/widgets/menu_item.dart';

extension CapExtension on String {
  String get capitalizeFirstofEach =>
      this.split(" ").map((str) => str.capitalize).join(" ");
}

class WeatherController extends GetxController {
  WeatherRepository repository = Get.find();

  Future<void> initializeController() async {
    await _updateFavoriteCities();
    if (_favorites.length > 0) {
      WeatherInfoModel weatherInfo =
          await repository.getWeatherInfoByCityID(_favorites[0].cityId);
      currWeatherInfo = weatherInfo.obs;
    } else {
      int bogotaID = 3688689;
      WeatherInfoModel weatherInfo =
          await repository.getWeatherInfoByCityID(bogotaID);
      currWeatherInfo = weatherInfo.obs;
    }
  }

  /* Weather Functionality */
  late Rx<WeatherInfoModel> currWeatherInfo;

  String get weatherTitle =>
      (currWeatherInfo.value.city + ", " + currWeatherInfo.value.country);

  String get iconpath => currWeatherInfo.value.icon;

  String get weatherMainDisplay =>
      currWeatherInfo.value.description.capitalizeFirstofEach +
      ", " +
      currWeatherInfo.value.temp +
      "°C";

  String get feelsLike =>
      "Feels Like Temperature: ${currWeatherInfo.value.feelsLike}°C";

  String get humidity => 'Humidity: ${currWeatherInfo.value.humidity} %';
  String get windSpeed => 'Wind Speed: ${currWeatherInfo.value.windSpeed} m/s';

  // Internal Helper
  void _updateWeatherDisplay(WeatherInfoModel information) async {
    currWeatherInfo.value = information;
  }

  void displayWeather(String cityNameQuerySearch, int geoID) async {
    repository
        .getWeatherInfo(cityNameQuerySearch, geoID)
        .then((info) => _updateWeatherDisplay(info))
        .catchError((error) =>
            {logError("Connection Error! Couldn't Fetch Information: $error")});
  }

  void displayWeatherByCityID(int cityID) async {
    repository
        .getWeatherInfoByCityID(cityID)
        .then((info) => _updateWeatherDisplay(info))
        .catchError((error) =>
            {logError("Connection Error! Couldn't Fetch Information $error")});
  }

  List<String> get cityNames => repository.getCityNames();
  List<String> get queryNames => repository.getCityQueryNames();
  List<int> get cityCodes => repository.getCityCodes();

  /* Favorite Functionality */
  final RxList<WeatherFavoriteModel> _favorites = <WeatherFavoriteModel>[].obs;

  bool get favDisplay => _checkFavCurrent();

  List<Widget> get favorites =>
      _favorites.map((e) => menuItem(e.city, e.cityId)).toList();
  // List<WeatherFavoriteModel> get favorites => _favorites.map((e) => e).toList();

  Future<void> _updateFavoriteCities() async {
    _favorites.value = await repository.getFavorites();
  }

  bool _checkFavCurrent() => _favorites
      .map((element) => element.cityId)
      .contains(currWeatherInfo.value.cityId);

  void toggleDisplayFavorite() async {
    if (_checkFavCurrent()) {
      await repository.deleteFavoriteCity(currWeatherInfo.value.cityId);
    } else {
      await repository.addFavoriteCity(currWeatherInfo.value.cityId);
    }
    await _updateFavoriteCities();
  }
}
