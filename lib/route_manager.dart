import 'package:bing_flutter/my_all_imports.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

///全局路由管理器，通过fluro插件实现路由管理，所有的路由都在此定义

final myRouter = FluroRouter();

const String main_route = 'main_route'; //主界面
const String setting_route = 'setting_route'; //设置
const String history_route = 'history_route'; //历史图片
const String test_route = 'test_route'; //测试

final mainHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return MainRoute();
});
final setHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return SettingRoute();
});
final historyHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return HistoryRoute();
});
final testHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  final args = context.settings.arguments as TestData;
  logD('testHandler  args=$args  params=$params');
  return TestRoute(args);
});

void defineRoutes() {
  logD(' defineRoutes ');
  myRouter.define(main_route, handler: mainHandler);
  myRouter.define(setting_route,
      handler: setHandler, transitionType: TransitionType.inFromRight);
  myRouter.define(history_route,
      handler: historyHandler, transitionType: TransitionType.fadeIn);
  myRouter.define(test_route, handler: testHandler);
}
