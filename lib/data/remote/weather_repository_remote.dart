import 'package:http/http.dart' as http;
import 'package:movil_parcial2/data/model/weather_model.dart';
import 'package:movil_parcial2/common/constants.dart';
import 'dart:convert';
import 'package:loggy/loggy.dart';

class WeatherRepositoryRemote {
  Future<WeatherInfoModel> getWeatherInfo(String cityName) async {
    var request = Uri.parse("https://api.openweathermap.org/data/2.5/weather")
        .resolveUri(Uri(queryParameters: {
      "q": cityName,
      "appid": API_KEY,
      "units": "metric",
      "lang": "es",
    }));

    logInfo("Fetching from remote with request: $request");
    var response = await http.get(request);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      logInfo("Received Status Code 200!");

      Map<String, dynamic> decoded = json.decode(jsonString);
      return WeatherInfoModel.fromJson(decoded);
    } else {
      logInfo("Received Error Code $response.statusCode");
    }

    return Future.error("error");
  }

  Future<WeatherInfoModel> getWeatherInfoByCityID(int cityID) async {
    var request = Uri.parse("https://api.openweathermap.org/data/2.5/weather")
        .resolveUri(Uri(queryParameters: {
      "id": cityID.toString(),
      "appid": API_KEY,
      "units": "metric",
      "lang": "es",
    }));

    logInfo("Fetching from remote with request: $request");
    var response = await http.get(request);
    if (response.statusCode == 200) {
      logInfo("Received Status Code 200!");

      var jsonString = response.body;

      return WeatherInfoModel.fromJson(json.decode(jsonString));
    } else {
      logInfo("Received Error Code $response.statusCode");
    }

    return Future.error("error");
  }
}
