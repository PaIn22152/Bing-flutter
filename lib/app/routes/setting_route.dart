import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingRoute extends StatefulWidget {
  @override
  _SettingRouteState createState() => _SettingRouteState();
}

class _SettingRouteState extends State<SettingRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: Text("tttt"),
    );
  }
}
