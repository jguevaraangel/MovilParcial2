class WeatherInfoModel {
  late String mainTitle;
  late String description;
  late String icon;

  late String temp;
  late String feelsLike;
  late String pressure;
  late String humidity;

  late String windSpeed;

  late int cityId;
  late String city;

  WeatherInfoModel({
    required this.description,
    required this.icon,
    required this.mainTitle,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.cityId,
    required this.city, // Favorite City display, no countries, only basic name
  });

  WeatherInfoModel.fromJson(Map<String, dynamic> json) {
    this.mainTitle = json["weather"]["main"];
    description = json["weather"]["description"];
    icon = json["weather"]["icon"];

    temp = json["main"]["temp"];
    feelsLike = json["main"]["feels_like"];
    pressure = json["main"]["pressure"];
    humidity = json["main"]["humidity"];

    windSpeed = json["wind"]["speed"];
    cityId = json["id"];
    city = json["name"];
  }
}
