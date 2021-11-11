import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movil_parcial2/domain/controller/weather_controller.dart';
import 'package:movil_parcial2/ui/widgets/menu_item.dart';

class BodyDrawer extends StatelessWidget {
  WeatherController C = Get.find();

  @override
  Widget build(BuildContext context) {
    // List<Obx> favdisplay =
    //     C.favorites.map((e) => Obx(() => menuItem(e.city))).toList();
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Obx(() => Column(
            children: C.favorites,
          )),
    );
  }
}
