import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';

import 'ble_wrap.dart';

///抽象化的蓝牙产品
abstract class BleProduct {
  BleProduct(this.bleName, this.serviceUuid, this.characteristicUuid,
      this.sign);

  String bleName = ''; //蓝牙名称
  String serviceUuid = ''; //蓝牙服务值
  String characteristicUuid = ''; //蓝牙特征值
  int sign = 0;

  bool connected = false;
  BleWrapper bleWrapper;
  BluetoothDevice device;

  ///解析数据
  ///[data]从设备接受到的数据
  void parseData(List<int> data);
}

class BleProductOne extends BleProduct {
  //1.设备蓝牙名称：MagicLamp(BLE)
  //2.设备蓝牙服务UUID：		 0000ae30-0000-1000-8000-00805f9b34fb
  //3.设备蓝牙服务特征值UUID：  0000ae10-0000-1000-8000-00805f9b34fb
  BleProductOne()
      : super('MagicLamp(BLE)', '0000ae30-0000-1000-8000-00805f9b34fb',
      '0000ae10-0000-1000-8000-00805f9b34fb', 1);

  @override
  void parseData(List<int> data) {}

  sendTest() {
    List<int>list = [];
    for (int i = 0; i < 50; i++) {
      list.add(i);
    }
    bleWrapper.send2Device(list);
  }
}

///具体的蓝牙产品
class BleProductTwo extends BleProduct {
  BleProductTwo() : super('bleName', 'serviceUuid', 'characteristicUuid', 2);

  Completer<bool> _openCompleter;

  @override
  void parseData(List<int> data) {
    //处理从设备接收到的数据

    //假设设备返回open操作相关的数据
    if (data[0] == 1) {
      //open操作是否成功
      _openCompleter.complete(data[1] == 1);
    }
  }

  Future<bool> open() async {
    _openCompleter = Completer();
    final List<int> comm = []; //根据协议组装数据
    bleWrapper.send2Device(comm); //发送数据到设备
    final timer = Timer(const Duration(seconds: 1), () {
      //发送数据后，超时时间内没有收到设备相关返回，判断失败
      _openCompleter.complete(false);
    });
    final callback = await _openCompleter.future;
    timer.cancel();
    return callback;
  }
}
