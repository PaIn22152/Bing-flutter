import 'dart:async';

import 'package:bing_flutter/my_all_imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screen_light/screen_light.dart';

///测试用路由，会在此写一些测试用代码
///

class TestData {
  final int age;
  final String name;

  TestData(this.age, this.name);
}

class TestRoute extends StatefulWidget {
  TestData _testData;

  TestRoute(this._testData);

  @override
  _TestRouteState createState() => _TestRouteState(_testData);
}

enum CounterEvent { increment, reduce }

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(10);

  @override
  void onEvent(CounterEvent event) {
    print('CounterBloc  event = $event');
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    print('CounterBloc  transition = $transition');
    super.onTransition(transition);
  }

  @override
  void onChange(Change<int> change) {
    print('CounterBloc  change = $change');
    super.onChange(change);
  }

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        yield state + 1;
        break;
      case CounterEvent.reduce:
        yield state - 1;
        break;
    }
  }
}

class GradientButton extends StatelessWidget {
  GradientButton({
    this.colors,
    this.width,
    this.height,
    this.onPressed,
    this.borderRadius,
    @required this.child,
  });

  // 渐变色数组
  final List<Color> colors;

  // 按钮宽高
  final double width;
  final double height;

  final Widget child;
  final BorderRadius borderRadius;

  //点击回调
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    //确保colors数组不空
    List<Color> _colors = colors ??
        [theme.primaryColor, theme.primaryColorDark ?? theme.primaryColor];

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: _colors),
        borderRadius: borderRadius,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.first,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TestRouteState extends State<TestRoute> with TickerProviderStateMixin {
  TestData _testData;

  _TestRouteState(this._testData);

  double size = 100.w;
  Color col = Colors.red[300];
  String text = 'abcdefg';
  double radius = 10;
  double opacity = 0.2;
  double bigc = 2;
  int maxlines = 2;
  Alignment alignment = Alignment.centerLeft;
  BoxShape shape = BoxShape.rectangle;

  int num = 0;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..addStatusListener((AnimationStatus status) {
            // if (status == AnimationStatus.completed) {
            //   animationController.reverse();
            // } else if (status == AnimationStatus.dismissed) {
            //   animationController.forward();
            // }
          });
    // animationController.forward();
  }

  @override
  dispose() {
    super.dispose();
    animationController.dispose();
    ScreenLight.instance.unlistenSysScreenLight();
  }



  void _() async {
    // final light = await ScreenLight.instance.getSysScreenLight();
    // logD('getSysScreenLight=$light');
    //
    // bool b2 = await ScreenLight.instance.setAppScreenLight(255);
    // logD('b2=$b2');
    // final light2 = await ScreenLight.instance.getAppScreenLight();
    // logD('getAppScreenLight2=$light2');

    ScreenLight.instance.listenSysScreenLight((light, selfChange) {
      logD('flutter  light=$light   self=$selfChange');
    });

    // bool b3 = await ScreenLight.instance.setAppScreenLight(251);
    // logD('b3=$b3');
    // final light23 = await ScreenLight.instance.getAppScreenLight();
    // logD('getAppScreenLight23=$light23');
  }



  @override
  Widget build(BuildContext context) {

    _();

    // return Scaffold(
    //   body: WillPopScope(
    //     onWillPop: () {
    //       // instanceWebController.goBack();
    //       return Future.value(true);
    //     },
    //     child: const WebView(
    //       // initialUrl: 'https://flutter.dev',
    //       // initialUrl: 'https://www.google.com.hk/?hl=zh-CN',
    //       initialUrl: 'http://payne.fun/',
    //       javascriptMode: JavascriptMode.unrestricted,
    //     ),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: const Text('widget.title 👿'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          GradientButton(
            colors: [Colors.grey, Colors.red],
            height: 50.0,
            child: Text("Submit"),
            onPressed: () {},
          ),
          GradientButton(
            borderRadius: BorderRadius.circular(10),
            height: 50.0,
            colors: [Colors.lightGreen, Colors.green[700]],
            child: Text("Submit"),
            onPressed: () {},
          ),
          AnimatedContainer(
            alignment: alignment,
            padding: EdgeInsets.all(radius),
            margin: EdgeInsets.all(radius),
            width: size,
            height: size,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius), color: col),
            duration: const Duration(seconds: 1),
          ),
          AnimatedAlign(
            alignment: alignment,
            // heightFactor: bigc,
            duration: const Duration(seconds: 1),
            child: const Text('text'),
          ),
          // Container(
          //   width: 100,
          //   height: 100,
          //   color: Colors.blue,
          //   child: Stack(
          //     children: [
          //       AnimatedPositioned(
          //         left: radius,
          //         width: radius,
          //         child: Text('AnimatedPositioned'),
          //         duration: const Duration(seconds: 1),
          //       )
          //     ],
          //   ),
          // ),
          // Container(
          //   width: 100,
          //   height: 100,
          //   color: Colors.blue,
          //   child: Stack(
          //     children: [
          //       AnimatedPositionedDirectional(
          //         end: radius,
          //         width: radius,
          //         child: Text('A12345l'),
          //         duration: const Duration(seconds: 1),
          //       )
          //     ],
          //   ),
          // ),
          AnimatedDefaultTextStyle(
            child: Container(
              child: Text('123'),
            ),
            maxLines: maxlines,
            style: TextStyle(color: col, fontSize: radius),
            duration: Duration(seconds: 1),
          ),
          AnimatedPhysicalModel(
            shadowColor: col,
            color: col,
            elevation: radius,
            child: Container(
              color: Colors.deepOrange,
              width: 120.w,
              height: 120.w,
            ),
            duration: Duration(seconds: 1),
            shape: shape,
          ),
          Container(
            color: Colors.grey,
            width: 60.w,
            height: 60.w,
            child: Center(
              child: Transform.scale(
                scale: 3,
                child: AnimatedIcon(
                  icon: AnimatedIcons.play_pause,
                  progress: animationController,
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.amber,
              child: Text('AnimatedOpacity'),
            ),
            duration: Duration(seconds: 1),
            opacity: opacity,
          ),
          InkWell(
            onTap: () {
              setState(() {
                if (num.isEven) {
                  size = 120.w;
                  col = Colors.blue;
                  text = 'hijklmnnnnn';
                  radius = 30;
                  alignment = Alignment.centerRight;
                  animationController.forward();
                  opacity = 0.8;
                  bigc = 200;
                  maxlines = 3;
                  shape = BoxShape.circle;
                } else {
                  size = 50.w;
                  col = Colors.green;
                  text = '12efgwehs';
                  radius = 10;
                  alignment = Alignment.centerLeft;
                  animationController.reverse();
                  opacity = 0.2;
                  bigc = 2;
                  maxlines = 2;
                  shape = BoxShape.rectangle;
                }
                num++;
              });
            },
            child: Container(
              padding: EdgeInsets.all(50.w),
              child: Text('change'),
            ),
          )
        ],
      ),
    );
  }
}
