import 'package:flutter/material.dart';

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
