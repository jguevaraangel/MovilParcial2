import 'package:hive/hive.dart';

part 'weatherdb_model.g.dart';

@HiveType(typeId: 0)
class WeatherInfoDB extends HiveObject {
  WeatherInfoDB({
    required this.description,
    required this.icon,
    required this.mainTitle,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.cityId,
    required this.city,
    required this.unixTimeStamp,
  });

  @HiveField(0)
  String description;
  @HiveField(1)
  String icon;
  @HiveField(2)
  String mainTitle;

  @HiveField(3)
  String temp;
  @HiveField(4)
  String feelsLike;
  @HiveField(5)
  String pressure;
  @HiveField(6)
  String humidity;

  @HiveField(7)
  String windSpeed;

  @HiveField(8)
  int cityId;

  @HiveField(9)
  String city;

  @HiveField(10)
  int unixTimeStamp;
}
