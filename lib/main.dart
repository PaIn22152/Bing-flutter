import 'package:bing_flutter/my_all_imports.dart';
import 'package:bing_flutter/routes/application/application_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Global.init(() {
    runApp(BlocProvider<ApplicationBloc>(
      child: BlocBuilder<ApplicationBloc, ApplicationState>(
          builder: (context, state) {
        logD('ApplicationBloc state=$state');

        //设置全屏
        if (spGetFullScreen()) {
          SystemChrome.setEnabledSystemUIOverlays([]);
        } else {
          SystemChrome.restoreSystemUIOverlays();
        }
        return MyApp();
      }),
      create: (_) => ApplicationBloc()..add(AppStartedEvent()),
    ));
  });
}

class Global {
  //初始化全局信息
  static Future init(VoidCallback callback) async {
    debugPaintSizeEnabled = false;

    //初始化sp
    await spInit();

    //设置全屏
    // SystemChrome.setEnabledSystemUIOverlays([]);
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    callback();
  }
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    defineRoutes();
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      allowFontScaling: false,
      child: MaterialApp(
        navigatorObservers: [routeObserver],
        debugShowCheckedModeBanner: true,
        // onGenerateRoute: MyRouter.generateRoute,
        onGenerateRoute: myRouter.generator,
        title: 'DailyPic',
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: spGetDarkTheme() ? Brightness.dark : Brightness.light,
          primaryColor: color_primary,
          accentColor: color_accent,

          // Define the default font family.
          fontFamily: 'Nunito',

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          // textTheme: const TextTheme(
          //   headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          // ),
        ),
        home: MainRoute(),
      ),
    );
  }
}
