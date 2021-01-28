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
  double radius = 0;
  double opacity = 0.2;
  Alignment alignment = Alignment.centerLeft;

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
            width: size,
            height: size,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius), color: col),
            duration: const Duration(seconds: 1),
          ),
          AnimatedAlign(
            alignment: alignment,
            duration: const Duration(seconds: 1),
            child: const Text('text'),
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
              child: Text('AnimatedOpacity'),),
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
                } else {
                  size = 50.w;
                  col = Colors.green;
                  text = '12efgwehs';
                  radius = 0;
                  alignment = Alignment.centerLeft;
                  animationController.reverse();
                  opacity = 0.2;
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
