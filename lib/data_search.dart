import 'package:flutter/material.dart';
import 'package:movil_parcial2/domain/controller/weather_controller.dart';
import 'package:get/get.dart';

class DataSearch extends SearchDelegate<String> {
  WeatherController C = Get.find();
  final List<String> cities;
  final List<int> geocodes;

  DataSearch({
    required this.cities,
    required this.geocodes,
  });

  // final cities = [
  //   "Bogotá",
  //   "Medellín",
  //   "Cartagena",
  //   "Barranquilla",
  //   "Neiva",
  // ];

  // final recentCities = [
  //   "Bogotá",
  //   "Medellin",
  // ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, query);
      },
    );
  }

  @override
  void showResults(BuildContext context) {
    return;
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        // ? recentCities
        ? []
        : cities
            .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          query = suggestionList[index];
          C.displayWeather(query);
          close(context, query);
        },
        leading: Icon(Icons.location_city),
        title: RichText(
            text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: [
              TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey))
            ])),
      ),
      itemCount: suggestionList.length,
    );
  }
}
