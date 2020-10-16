import 'package:flutter/material.dart';
import 'package:flutter_demo/app/routes/history_route.dart';
import 'package:flutter_demo/app/routes/home_route.dart';
import 'package:flutter_demo/app/routes/setting_route.dart';
import 'package:flutter_demo/app/utils/router_anim.dart';

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
  static const String home = 'home';
  static const String setting = 'setting';
  static const String history = 'history';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //根据名称跳转相应页面
      case home:
        return NoAnimRouter(child: HomeRoute());
      case setting:
        return Right2LeftRouter(child: SettingRoute());
      case history:
        return FadeRouter(child: HistoryRoute());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
