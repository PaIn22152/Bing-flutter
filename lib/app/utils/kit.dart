import 'package:flutter/material.dart';
import 'file:///D:/as/work-space/AA-git-projects/Bing-flutter-git/lib/app/res/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

///工具包，包括统一的toast

void toast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      // backgroundColor: Color.fromARGB(180, 180, 180, 180),
      backgroundColor: toastBgColor,
      // backgroundColor: Colors.blue,
      textColor: Colors.white,
      webPosition: "center",
      fontSize: 16.0);
}
