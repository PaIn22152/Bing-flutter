import 'package:date_format/date_format.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bing_flutter/app/utils/log.dart';

///测试用路由，会在此写一些测试用代码

class TestRoute extends StatefulWidget {
  @override
  _TestRouteState createState() => _TestRouteState();
}

class _TestRouteState extends State<TestRoute> {
  final FijkPlayer player = FijkPlayer();

  @override
  void initState() {
    super.initState();
    player.setDataSource(
        "https://sample-videos.com/video123/flv/240/big_buck_bunny_240p_10mb.flv",
        autoPlay: true);
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }

  f(int o, {bool b = false, int i}) {
    L.d('b=$b  o=$o');
    if (b) {
      L.d('i=$i');
    }
  }

  add(double a, double b, [double discount = 1.0, double d = 0]) {
    L.d('add=${(a + b) * discount}');
  }

  double add2(double a, double b, rr, r2) {
    return rr(a) + r2(b);
  }

  assertF() async {
    assert(1 > 0);//true
    L.d("assert1");
    assert(1 > 2);//false
    L.d("assert2");
  }

  @override
  Widget build(BuildContext context) {
    String ss = "aab";
    L.d(ss.codeUnits);

    // var evil = '\u{1f47f}';
    // var evil = '👿';
    // L.d(evil); //👿
    // L.d(evil.codeUnits); //👿
    //
    // var i;
    // L.d(i);
    // i ??= 10;
    // L.d(i);
    // i ??= 33;
    // L.d(i);
    // i = '33';
    // L.d(i);
    //
    // f(0);
    // f(0, b: true);
    // f(0, b: false, i: 123);
    // f(0, b: true, i: 345);
    //
    // add(2, 3);
    // add(2, 3, 4);

    var fun = (i) => i * i;
    var fun2 = (double i) {
      return i * i * i;
    };
    L.d("add2=${add2(1, 2, fun, fun2)}");

    assertF();

    Size s=Size(1, 1);
    s.isEmpty;


    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('widget.title 👿'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: FijkView(player: player),
      ),
    );
  }
}
