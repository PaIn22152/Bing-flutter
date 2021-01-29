import 'package:bing_flutter/my_all_imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class _TestRouteState extends State<TestRoute> with TickerProviderStateMixin {
  TestData _testData;

  _TestRouteState(this._testData);

  double size = 100.w;
  Color col = Colors.red;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('widget.title 👿'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
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
