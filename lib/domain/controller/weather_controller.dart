import 'package:get/get.dart';
// import 'package:flutter/material.dart';
import 'package:movil_parcial2/data/model/weather_model.dart';
import 'package:movil_parcial2/data/model/weatherfavorite_model.dart';
import 'package:movil_parcial2/data/repositories/weather_repository.dart';

class WeatherController extends GetxController {
  WeatherRepository repository = Get.find();

  final RxList<WeatherFavoriteModel> favorite = <WeatherFavoriteModel>[].obs;

  late Rx<WeatherInfoModel> currWeatherInfo;

  void displayWeather(String city) {
    print(city);
  }

  // Future<List<String>> get cityNames() =>
  List<String> get cityNames => repository.getCityNames();
  List<int> get cityCodes => repository.getCityCodes();

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
