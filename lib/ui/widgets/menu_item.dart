import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movil_parcial2/domain/controller/weather_controller.dart';

Widget menuItem(String city, int cityID) {
  WeatherController C = Get.find();
  return Material(
    child: InkWell(
      onTap: () {
        C.displayWeatherByCityID(cityID);
        Get.back();
      },
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  city,
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                )),
          ],
        ),
      ),
    ),
  );
}
