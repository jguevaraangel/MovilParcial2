import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movil_parcial2/domain/controller/weather_controller.dart';
import 'package:movil_parcial2/ui/widgets/body_drawer.dart';
import 'package:movil_parcial2/ui/widgets/data_search.dart';
import 'package:movil_parcial2/ui/widgets/header_drawer.dart';

class HomePage extends StatelessWidget {
  final WeatherController C = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weathery'),
        backgroundColor: Colors.teal[400],
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await showSearch(
                  context: context,
                  delegate: DataSearch(
                    cities: C.cityNames,
                    geocodes: C.cityCodes,
                    queryNames: C.queryNames,
                  ));
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                HeaderDrawer(),
                // Obx(
                //   () => BodyDrawer(),
                // ),
                BodyDrawer(),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Obx(() => Text(
                  C.weatherTitle,
                  style: GoogleFonts.merriweather(
                    fontSize: 30.0,
                  ),
                )),
            // Icon(Icons.beach_access, color: Colors.blue, size: 36.0),
            Obx(() => Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    'https://openweathermap.org/img/wn/${C.iconpath}@2x.png',
                  ),
                )),

            Obx(
              () => Text(C.weatherMainDisplay,
                  style: GoogleFonts.merriweather(
                    fontSize: 25.0,
                  )),
            ),
            Obx(
              () => Text(C.feelsLike,
                  style: GoogleFonts.merriweather(
                    fontSize: 20.0,
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Obx(() => Text(
                      C.humidity,
                      style: GoogleFonts.merriweather(
                        fontSize: 15.0,
                      ),
                    )),
                Obx(() => Text(
                      C.windSpeed,
                      style: GoogleFonts.merriweather(
                        fontSize: 15.0,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(() => FloatingActionButton(
            backgroundColor:
                (C.favdisplay) ? Colors.red[700] : Color(0xff9A9A9A),
            splashColor: (C.favdisplay) ? Colors.red[700] : Color(0xff9A9A9A),
            onPressed: () {
              C.toggleDisplayFavorite();
            },
            child: const Icon(Icons.favorite),
          )),
      bottomNavigationBar: BottomAppBar(
        color: Colors.teal[400],
        child: Container(
          height: 40.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
