class WeatherFavoriteModel {
  WeatherFavoriteModel(
      {required this.id, required this.cityId, required this.city});

  int id;
  int cityId;
  String city; // Favorite City display, no countries, only basic name
}
