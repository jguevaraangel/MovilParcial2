import 'package:http/http.dart' as http;
import 'package:movil_parcial2/data/model/weather_model.dart';
import 'package:movil_parcial2/common/constants.dart';
import 'dart:convert';

class WeatherRepositoryRemote {
  Future<WeatherInfoModel> getWeatherInfo(String cityName) async {
    var request = Uri.parse("https://api.openweathermap.org/data/2.5/weather")
        .resolveUri(Uri(queryParameters: {
      "q": cityName,
      "appid": API_KEY,
      "units": "metric",
      "lang": "es",
    }));

    var response = await http.get(request);
    if (response.statusCode == 200) {
      print("Got code 200");

      var jsonString = response.body;

      return WeatherInfoModel.fromJson(json.decode(jsonString));
    } else {
      print("Got error code ${response.statusCode}");
    }

    return Future.error("error");
  }
}
