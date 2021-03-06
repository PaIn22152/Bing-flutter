///sp实现类，所有sp相关的，都统一在此写，包括put和get
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences _sp;

Future<bool> spInit() async {
  _sp ??= await SharedPreferences.getInstance();
  return Future.value(true);
}

//get的简单封装，增加默认返回值
dynamic _spGetDef(String key, dynamic def) {
  final dynamic res = _sp?.get(key);
  if (res == null) {
    return def;
  } else
    return res;
}

//put的简单封装
Future<bool> _spPutString(String key, String value) async {
  await spInit();
  return _sp?.setString(key, value);
}

Future<bool> _spPutInt(String key, int value) async {
  await spInit();
  return _sp?.setInt(key, value);
}

Future<bool> _spPutDouble(String key, double value) async {
  await spInit();
  return _sp?.setDouble(key, value);
}

Future<bool> _spPutBool(String key, bool value) async {
  await spInit();
  return _sp?.setBool(key, value);
}

//测试
const String _key_test = '_key_test';

Future spTestPut(String s) async {
  return _spPutString(_key_test, s);
}

String spTestGet() {
  return _spGetDef(_key_test, '') as String;
}

///下载图片质量
const String _key_pic_quality = 'key_pic_quality';

Future<bool> spPutPicQuality(double i) {
  return _spPutDouble(_key_pic_quality, i);
}

double spGetPicQuality() {
  return _spGetDef(_key_pic_quality, 50.toDouble()) as double;
}

/// 是否使用暗黑模式
const String _key_dark_theme = '_key_dark_theme';

Future<bool> spPutDarkTheme(bool b) {
  return _spPutBool(_key_dark_theme, b);
}

bool spGetDarkTheme() {
  return _spGetDef(_key_dark_theme, false) as bool;
}

///是否全屏
const String _key_full_screen = '_key_full_screen';

Future<bool> spPutFullScreen(bool b) {
  return _spPutBool(_key_full_screen, b);
}

bool spGetFullScreen() {
  return _spGetDef(_key_full_screen, false) as bool;
}
