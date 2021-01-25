import 'package:bing_flutter/my_all_imports.dart';
import 'package:flutter/material.dart';

class AppAnalysis extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (route.settings.name != null) {}
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (route.settings.name != null) {}
  }
}

class MyRouter {
  static const String main = 'main';
  static const String setting = 'setting';
  static const String history = 'history';
  static const String test = 'test';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //根据名称跳转相应页面
      case main:
        return NoAnimRouter<dynamic>(child: MainRoute());
      case setting:
        return Bottom2TopRouter<dynamic>(child: SettingRoute());
      case history:
        return ScaleFadeRotateRouter<dynamic>(child: HistoryRoute());
      case test:
        return FadeRouter<dynamic>(child: TestRoute(null));
      default:
        return MaterialPageRoute<dynamic>(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
