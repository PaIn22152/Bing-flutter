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
        //设置全屏
        if (spGetFullScreen()) {
          SystemChrome.setEnabledSystemUIOverlays([]);
        } else {
          SystemChrome.setEnabledSystemUIOverlays(
              [SystemUiOverlay.top, SystemUiOverlay.bottom]);
        }
        _runOnlyOnce('mgo', () {
          Bloc.observer = MyBlocObserver();
        });

        return MyApp();
      }),
      create: (_) => ApplicationBloc()..add(AppStartedEvent()),
    ));
  });
}

final _map = <String, bool>{};

void _runOnlyOnce(String tag, Function f) {
  if (!(_map[tag] ?? false)) {
    f();
    _map[tag] = true;
  }
}

class Global {
  //初始化全局信息
  static Future init(VoidCallback callback) async {
    debugPaintSizeEnabled = false;

    //初始化sp
    await spInit();

    callback();
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print('MyBlocObserver bloc = $bloc ; event = $event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('MyBlocObserver bloc = $bloc ; transition = $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    print('MyBlocObserver cubit = $cubit ; change = $change');
    super.onChange(cubit, change);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print(
        'MyBlocObserver onError  cubit=$cubit  error=$error  stackTrace=$stackTrace');
    super.onError(cubit, error, stackTrace);
  }
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // logD('MyAppState  build');
    _runOnlyOnce('masb', () {
      // logD('_runOnlyOnce');
      //禁用横屏，强制竖屏
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      defineRoutes();
    });

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
        ),
        home: MainRoute(),
        // home: TestRoute(null),
      ),
    );
  }
}
