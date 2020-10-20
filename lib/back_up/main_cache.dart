// import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class RouterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hhh"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            var result = await Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return TipRoute(
                    text: "this is text1111",
                  );
                }));
            print(" result = $result");
          },
          child: Text("打开提示页面"),
        ),
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  TipRoute({Key key, @required this.text}) : super(key: key);
  final String text;

  void _printInfo() async {
    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // print(
    //     'Running on  model=${androidInfo.model}  androidId=${androidInfo.androidId}   product=${androidInfo.product}'); // e.g. "Moto G (4)"

    // IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    // print('Running on ${iosInfo.utsname.machine}');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Tip Route")),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text(text),
            Image(
              width: 50,
              height: 50,
              image: new AssetImage("assets/png/icon_delete.png"),
            ),
            Image.asset(
              "assets/png/icon_delete.png",
              width: 100,
              height: 100,
            ),
            RaisedButton(
              onPressed: () {
                _printInfo();
                // Navigator.pop(context, "返回值1  from=$text");
              },
              child: Text("返回23"),
            )
          ],
        ),
      ),
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blue,
        title: Text("new Route"),
      ),
      body: new Center(
        child: GestureDetector(
          child: Text(" hhhhhhh"),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        "new_page": (context) => NewRoute(),
        "tip_page": (context) =>
            TipRoute(text: ModalRoute.of(context).settings.arguments),
      },
      // home: new RouterTestRoute(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            new FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, "new_page");
              },
              child: Text(" open new route!"),
              textColor: Colors.blue,
            ),
            new FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, "tip_page",
                    arguments: "pushNamed");
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return new TipRoute(text: "from  home");
                // }));
              },
              child: Text(" open Tip route!"),
              textColor: Colors.blue,
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
