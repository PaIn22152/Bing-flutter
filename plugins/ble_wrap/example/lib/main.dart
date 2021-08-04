import 'package:ble_wrap/ble_export.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  final BleWrapper<BleProductOne> wrapper =
      ProductFactory.createBleProductOneWrapper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Wrap(
          children: [
            ElevatedButton(
              onPressed: () {
                wrapper.startScanBle((suc) {
                  logD('startScanBle  suc=$suc');
                });
              },
              child: Text('startScan'),
            ),
            ElevatedButton(
              onPressed: () {
                wrapper.bleProduct.sendTest();
              },
              child: Text('startScan'),
            ),
          ],
        ),
      ),
    );
  }
}
