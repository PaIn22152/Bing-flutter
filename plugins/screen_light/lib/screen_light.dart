import 'dart:async';

import 'package:flutter/services.dart';

///唯一通道名
const String _channel_name = 'payne/perdev/screen_light';

///方法名
const String _getSysScreenLight = 'getSysScreenLight';
const String _listenSysScreenLight = 'listenSysScreenLight';
const String _unlistenSysScreenLight = 'unlistenSysScreenLight';
const String _getAppScreenLight = 'getAppScreenLight';
const String _setAppScreenLight = 'setAppScreenLight';

///参数名
const String _argLight = 'argLight';
const String _argSelfChange = 'argSelfChange';

///回调方法名
const String _callbackSysScreenLightChanged = 'callbackSysScreenLightChanged';

///系统屏幕亮度改变回调
typedef SysScreenLightChanged = void Function(int, bool);

class ScreenLight {
  final MethodChannel _channel = const MethodChannel(_channel_name);

  static ScreenLight _instance;

  static ScreenLight get instance {
    _instance ??= ScreenLight._();

    return _instance;
  }

  ScreenLight._() {
    _channel.setMethodCallHandler((call) => _handleMethod(call));
  }

  final List<SysScreenLightChanged> _list = [];

  ///获取系统屏幕亮度
  ///范围[0,255]
  Future<int> getSysScreenLight() {
    return _invokeIntMethod(_getSysScreenLight);
  }

  ///监听系统屏幕亮度改变
  ///当系统屏幕亮度发生改变时，回调此方法
  Future<bool> listenSysScreenLight(SysScreenLightChanged f) {
    _list.add(f);
    return _invokeBooleanMethod(_listenSysScreenLight);
  }

  ///取消监听系统屏幕亮度改变
  Future<bool> unlistenSysScreenLight() {
    _list.clear();
    return _invokeBooleanMethod(_unlistenSysScreenLight);
  }

  ///获取当前应用屏幕亮度
  ///范围[0,255]
  Future<int> getAppScreenLight() {
    return _invokeIntMethod(_getAppScreenLight);
  }

  ///设置当前应用屏幕亮度
  ///范围[0,255]
  Future<bool> setAppScreenLight(int light) {
    if (light < 0) {
      light = 0;
    } else if (light > 255) {
      light = 255;
    }
    return _invokeBooleanMethod(
        _setAppScreenLight, <String, int>{_argLight: light});
  }

  ///调用platform方法，并返回bool
  Future<bool> _invokeBooleanMethod(String method, [dynamic arguments]) async {
    final bool result = await _channel.invokeMethod<bool>(
      method,
      arguments,
    );
    return result;
  }

  ///调用platform方法，并返回int
  Future<int> _invokeIntMethod(String method, [dynamic arguments]) async {
    final int result = await _channel.invokeMethod<int>(
      method,
      arguments,
    );
    return result;
  }

  ///回调，platform主动调用channel.invokeMethod方法后，会走到此处
  Future<dynamic> _handleMethod(MethodCall call) {
    switch (call.method) {
      case _callbackSysScreenLightChanged:
        final map = call.arguments as Map<dynamic, dynamic>;
        final light = map[_argLight] as int;
        final selfChange = map[_argSelfChange] as bool;
        _list.forEach((v) {
          v(light, selfChange);
        });
        break;
    }
    return Future<dynamic>.value(null);
  }
}
