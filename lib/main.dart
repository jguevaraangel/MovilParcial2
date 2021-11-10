import 'package:flutter/material.dart';
import 'package:movil_parcial2/data/repositories/weather_repository.dart';
import 'package:movil_parcial2/data_search.dart';
import 'package:movil_parcial2/domain/controller/weather_controller.dart';
import 'package:movil_parcial2/ui/header_drawer.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

// Future<List<Box>> _openBox() async {
//   List<Box> boxList = [];
//   var dir = await path_provider.getApplicationDocumentsDirectory();
//   Hive.init(dir.path);
//   Hive.registerAdapter(UserDBAdapter());
//   var user_session = await Hive.openBox("users");
//   boxList.add(user_session);
//   return boxList;
// }

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
  Get.put(WeatherController());

  await Hive.initFlutter();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WeatherController C = Get.find();

  bool _isFavorite = false;
  _addFavorite() {
    var newBool = true;
    if (_isFavorite) {
      newBool = false;
    } else {
      newBool = true;
    }

    setState(() {
      _isFavorite = newBool;
    });
  }

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
                  delegate:
                      DataSearch(cities: C.cityNames, geocodes: C.cityCodes));
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
                drawerList(),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: (_isFavorite) ? Colors.red[700] : Color(0xff9A9A9A),
        splashColor: (_isFavorite) ? Colors.red[700] : Color(0xff9A9A9A),
        onPressed: () {
          _addFavorite();
        },
        child: const Icon(Icons.favorite),
      ),
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

Widget drawerList() {
  return Container(
    padding: EdgeInsets.only(
      top: 15,
    ),
    child: Column(
      children: [
        menuItem("Medellin"),
        menuItem("Bogotá"),
        menuItem("Cartagena"),
        menuItem("Neiva"),
        menuItem("Barranquilla"),
      ],
    ),
  );
}

Widget menuItem(String city) {
  return Material(
    child: InkWell(
      onTap: () {},
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

enum DrawerSections { Medellin, Bogota, Cartagena, Neiva, Barranquilla }
