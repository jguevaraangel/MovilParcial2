import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
// import 'package:flutter/material.dart';
import 'package:movil_parcial2/data/model/weather_model.dart';
import 'package:movil_parcial2/data/model/weatherfavorite_model.dart';
import 'package:movil_parcial2/data/repositories/weather_repository.dart';
import 'package:movil_parcial2/main.dart';

class WeatherController extends GetxController {
  WeatherRepository repository = Get.find();

  final RxList<WeatherFavoriteModel> _favorites = <WeatherFavoriteModel>[].obs;

  List<Widget> get favorites =>
      _favorites.map((e) => menuItem(e.city)).toList();

  late Rx<WeatherInfoModel> currWeatherInfo;

  Future<void> initializeController() async {
    _updateFavoriteCities();
  }

  void _updateFavoriteCities() async {
    _favorites.value = await repository.getFavorites();
  }

  void _updateWeatherDisplay(WeatherInfoModel information) {
    addFavoriteCity(information.cityId);
    logDebug("Added ${information.city} to favorites!");
    return;
  }

  void displayWeather(String city, int geoID) async {
    repository
        .getWeatherInfo(city, geoID)
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
  List<int> get cityCodes => repository.getCityCodes();

  Future<void> addFavoriteCity(int cityId) async =>
      await repository.addFavoriteCity(cityId);
  Future<void> deleteFavoriteCity(int cityId) async =>
      await repository.deleteFavoriteCity(cityId);
  // final RxBool _loading = false.obs;

  // bool get loading => _loading.value;
  // List<NewsItem> get news => _news;

  // bool emptyNews() {
  //   return _news.isEmpty;
  // }

  // void getNews(String topic) async {
  //   _loading.value = true;
  //   Get.find<News>().getNews(topic).then((value) {
  //     _news.value = value;
  //     _loading.value = false; // Done loading
  //   }).catchError((error) {
  //     Get.snackbar('Error!', error,
  //         snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  //     _loading.value = false;
  //   });
  // }

  // void reset() {
  //   _news.value = <NewsItem>[].obs;
  // }
}
