///sp实现类，所有sp相关的，都统一在此写，包括put和get
import 'package:shared_preferences/shared_preferences.dart';

//get的简单封装，增加默认返回值
_spGetStringDef(String key, String def) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  dynamic res = sharedPreferences.get(key);
  if (res == null) {
    return def;
  } else
    return res;
}

_spGetIntDef(String key, int def) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  dynamic res = sharedPreferences.get(key);
  if (res == null) {
    return def;
  } else
    return res;
}

//put的简单封装
_spPutString(String key, value) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString(key, value);
}

_spPutInt(String key, int value) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setInt(key, value);
}

//测试
const String key_test = 'key_test';

Future spTestPut(String s) async {
  _spPutString(key_test, s);
}

Future spTestGet() async {
  return _spGetStringDef(key_test, "");
}

//下载图片质量
const String key_pic_quality = 'key_pic_quality';

Future spPutPicQuality(int i) async {
  _spPutInt(key_pic_quality, i);
}

Future spGetPicQuality() async {
  return _spGetIntDef(key_pic_quality, 50);
}
