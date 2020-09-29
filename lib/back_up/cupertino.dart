import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// void main() => runApp(new MyApp());
// void main() {
//   runApp(new MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new CupertinoApp(
      title: 'Flutter Demo',
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
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
  // int _counter = 100;

  void _incrementCounter() {
    setState(() {
      // _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), title: Text('tab1')),
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('tab2')),
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('tab3')),
        ],
      ),
      tabBuilder: (context, index) {
        return Center(
          child: Container(
              child: CupertinoButton(
                child: Text(//按钮label
                  'CupertinoButton   $index',
                ),
                color: Colors.blue,//按钮颜色
                onPressed: (){
                  print("hhhha   $index");
                  _incrementCounter();
                },//按下事件回调
              )
          ),
        );
      },
      controller: CupertinoTabController(),
    );
  }
}
