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

class _TestRouteState extends State<TestRoute> {
  TestData _testData;

  _TestRouteState(this._testData);

  Future<void> _increment() async {
    bloc.add(CounterEvent.increment);
  }

  Future<void> _reduce() async {
    bloc.add(CounterEvent.reduce);
  }

  Widget _blocBuilder() {
    return BlocBuilder<CounterBloc, int>(
      cubit: bloc,
      buildWhen: (previousState, state) {
        return state.isEven;
        // return state % 2 == 0;
      },
      builder: (context, state) {
        return Container(
          child: Text('_blocBuilder  state=$state'),
        );
      },
    );
  }

  CounterBloc bloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    Bloc.observer = MyBlocObserver();
    // bloc.listen(print);
    bloc.listen((s) {
      setState(() {});
    });
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('widget.title 👿'),
      // ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 120,
              height: 120,
              color: Colors.blue,
              child: Center(
                child: Text('topLeft'),
              ),
            ),
          ),
          Center(
              child: Container(
                height: 80,
            color: Colors.green,
            child: Text('Center'),
          )),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 120,
              height: 120,
              color: Colors.red,
              child: Center(
                child: Text('bottomRight'),
              ),
            ),
          ),
          // Center(
          //   child: Text('name=${_testData?.name}  age=${_testData?.age}'),
          // ),
          // Center(
          //   child: Text('cubit=${bloc.state}'),
          // ),
          // RaisedButton(
          //   onPressed: () {
          //     _increment();
          //   },
          //   child: const Text('add 1'),
          // ),
          // RaisedButton(
          //   onPressed: () {
          //     _reduce();
          //   },
          //   child: const Text('reduce 1'),
          // ),
          // _blocBuilder(),
          // _blocListener(),
        ],
      ),
    );
  }
}
