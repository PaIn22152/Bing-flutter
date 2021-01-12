import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///测试用路由，会在此写一些测试用代码

class TestRoute extends StatefulWidget {
  @override
  _TestRouteState createState() => _TestRouteState();
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
        return state % 2 == 0;
      },
      builder: (context, state) {
        return Container(
          child: Text('_blocBuilder  state=$state'),
        );
      },
    );
  }

  Widget _blocConsumer() {
    return BlocConsumer(
        cubit: bloc,
        builder: (c, s) {
          return Text('_blocConsumer  state=$s');
        },
        listener: (c, s) {});
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
      appBar: AppBar(
        title: Text('widget.title 👿'),
      ),
      body: Column(
        children: [
          Center(
            child: Text('cubit=${bloc.state}'),
          ),
          RaisedButton(
            onPressed: () {
              _increment();
            },
            child: Text('add 1'),
          ),
          RaisedButton(
            onPressed: () {
              _reduce();
            },
            child: Text('reduce 1'),
          ),
          _blocBuilder(),
          _blocConsumer(),
          // _blocListener(),
        ],
      ),
    );
  }
}
