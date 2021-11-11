import 'package:flutter/material.dart';
import 'package:movil_parcial2/data/repositories/weather_repository.dart';
import 'package:movil_parcial2/domain/controller/weather_controller.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:movil_parcial2/data/model/weatherdb_model.dart';
import 'package:movil_parcial2/data/model/weatherfavoritedb_model.dart';
import 'package:movil_parcial2/ui/pages/homepage.dart';

// Future<List<Box>> _openBox() async {
//   List<Box> boxList = [];
//   var dir = await path_provider.getApplicationDocumentsDirectory();
//   Hive.init(dir.path);
//   Hive.registerAdapter(UserDBAdapter());
//   var user_session = await Hive.openBox("users");
//   boxList.add(user_session);
//   return boxList;
// }

Future<void> initHive() async {
  logInfo("Initializing Hive Adapters!");
  Hive.registerAdapter(WeatherInfoDBAdapter());
  Hive.registerAdapter(WeatherFavoriteDBAdapter());
  logInfo("Opening Hive Boxes!");
  await Hive.openBox("geo2city");
  await Hive.openBox("favorites");
  await Hive.openBox("weatherinfo");
  logInfo("Boxes Ready!");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await _openBox();
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );

  // Get.put(Connectivity());
  // Connectivity c = Get.find();
  // Get.put(NetworkInfo(connectivity: c));
  WeatherRepository repo = WeatherRepository();
  repo.initializeData();
  Get.put(repo);

  await Hive.initFlutter();
  await initHive();

  WeatherController cont = WeatherController();
  await cont.initializeController();
  logInfo("Weather Controller Initialized!");
  Get.put(cont);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
