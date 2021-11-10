import 'package:get/get.dart';
import 'package:flutter/material.dart';

class WeatherController extends GetxController {
  WeatherRepository repository = Get.find();

  final RxList<int> cityCodes = <int>[].obs; // stored city names.
  final RxList<int> favCityCodes = <int>[].obs;

  final RxMap<int, String> favoriteCityNames =
      <int, String>{}.obs; // favorite city names.

  final RxMap<int, WeatherInfo> cityWeatherInfo =
      <int, WeatherInfo>{}; // Maps city code to info.

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
