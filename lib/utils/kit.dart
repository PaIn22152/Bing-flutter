import 'package:bing_flutter/my_all_imports.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///工具包，包括统一的toast

void toast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      // backgroundColor: Color.fromARGB(180, 180, 180, 180),
      backgroundColor: toastBg,
      // backgroundColor: Colors.blue,
      textColor: Colors.white,
      webPosition: 'center',
      fontSize: 16.0);
}
