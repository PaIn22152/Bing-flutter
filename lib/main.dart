import 'package:bing_flutter/my_all_imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      allowFontScaling: false,
      child: MaterialApp(
        navigatorObservers: [routeObserver],
        debugShowCheckedModeBanner: true,
        onGenerateRoute: MyRouter.generateRoute,
        title: 'DailyPic',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainRoute(),
      ),
    );
  }
}
