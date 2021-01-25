import 'dart:ui';

import 'package:flutter/material.dart';

///所有自定义颜色，都放在此处，相当于Android中的colors.xml文件

const Color test1 = Color.fromARGB(180, 180, 180, 180);
const Color test2 = Color(0xBB2E98F5); //自定义颜色推荐这种写法
const Color test3 = Colors.blue;
Color test4 = Color(int.parse('0xBB2E98F5'));

const Color color_theme = Color(0xFF2E98F5);
const Color color_primary = color_theme;
const Color color_accent = Color(0xFF4F78FF);
const Color toastBg = Color(0xBB2E98F5);
const Color historyDateBg = Color(0xAA616161);
const Color homeCopyrightBg = Color(0x66666666);
