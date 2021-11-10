import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class WeatherFavoriteDB extends HiveObject {
  WeatherFavoriteDB({required this.cityId, required this.city});

  @HiveField(0)
  int cityId;
  @HiveField(1)
  String city;
}
