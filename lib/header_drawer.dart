import 'package:flutter/material.dart';

class HeaderDrawer extends StatefulWidget {
  @override
  _HeaderDrawerState createState() => _HeaderDrawerState();
}

class _HeaderDrawerState extends State<HeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal[400],
      width: double.infinity,
      height: 80,
      padding: EdgeInsets.only(top: 40.0),
      child: Column(
        children: [
          Text(
            'Favorite Cities',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}
