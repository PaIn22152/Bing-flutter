import 'package:flutter/material.dart';

///屏幕适配

double _sw(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double _sh(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double _st(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

//按屏幕宽适配，分为360份
double _rpx(BuildContext context, double val) {
  return _sw(context) / 360 * val;
}
