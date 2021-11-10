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

  late int unixTimestamp;
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
    required this.unixTimestamp,
  });

  WeatherInfoModel.fromJson(Map<String, dynamic> json) {
    this.mainTitle = json["weather"][0]["main"];
    description = json["weather"][0]["description"];
    icon = json["weather"][0]["icon"];

    temp = json["main"]["temp"].toString();
    feelsLike = json["main"]["feels_like"].toString();
    pressure = json["main"]["pressure"].toString();
    humidity = json["main"]["humidity"].toString();

    windSpeed = json["wind"]["speed"].toString();
    cityId = json["id"];
    city = json["name"];
    unixTimestamp = json["dt"];
  }
}
