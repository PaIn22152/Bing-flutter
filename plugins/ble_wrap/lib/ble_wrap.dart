import 'dart:async';

import 'package:ble_wrap/ble_product.dart';
import 'package:ble_wrap/util.dart';
import 'package:flutter_blue/flutter_blue.dart';

///负责蓝牙设备的搜索，连接，发送数据，接收数据
///不涉及数据的组装，解析，和设备的具体功能
///设备的具体功能，交由具体的[BleProduct]处理

///蓝牙设备连接回调
typedef BleConnectListener = void Function(bool suc);

FlutterBlue _flutterBlue = FlutterBlue.instance;

BleWrapper<BleProductOne> bleGenerationOne = BleWrapper(BleProductOne());

///for test
// BleWrapper<BleProductTwo> bleGenerationTwo = BleWrapper(BleProductTwo());

///返回手机蓝牙是否开启
Future<bool> isBluetoothOn() {
  return _flutterBlue.isOn;
}

class BleWrapper<T extends BleProduct> {
  T bleProduct;

  BleWrapper(this.bleProduct) {
    bleProduct.bleWrapper = this;
  }

  BleConnectListener _bleConnectedListener;
  BluetoothCharacteristic _characteristic;

  startScanBle(BleConnectListener listener) async {
    _bleConnectedListener = listener;
    logD('startScanBle');

    BluetoothDevice tem;
    var connectedDevices = await _flutterBlue.connectedDevices;
    connectedDevices.forEach((device) {
      if (device.name.startsWith(bleProduct.bleName)) {
        tem = device;
        return;
      }
    });
    _discovering = false;
    if (tem != null) {
      logD('startScanBle  11');
      await tem.disconnect();
      _discoverServices(tem);
      return;
    }

    ///监听扫描设备的结果
    _flutterBlue.scanResults.listen((results) async {
      for (ScanResult r in results) {
        // if(r.device.name.isNotEmpty){
        //   logD("发现设备  name=${r.device.name}  type=${r.device.type}   id=${r.device.id}  ");
        // }

        if (r.device.name.startsWith(bleProduct.bleName)) {
          _flutterBlue.stopScan();
          _discoverServices(r.device);
        }
      }
    }, onError: _onError);

    logD('startScanBle   22');

    ///开始扫描设备
    _flutterBlue.startScan(timeout: Duration(seconds: 4));
  }

  void _onError(e) {
    _bleConnectedListener(false);
  }

  bool _discovering = false;

  ///发现所有设备
  _discoverServices(BluetoothDevice device) async {
    if (_discovering) {
      return;
    }

    _discovering = true;
    logD("发现设备  id=${device.id}  name=${device.name}  type=${device.type}");
    // android  id=EC:2C:0A:01:48:3D    是设备mac地址
    // ios      id=98B79FD6-790C-4364-980A-98D351F72B8E    是设备uuid

    await device.disconnect();
    await device.connect(autoConnect: false).timeout(Duration(seconds: 5),
        onTimeout: () {
          logD('timeout occured');
          device.disconnect();
        }).then((data) {
      logD('connection successful');
    });

    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) {
      var value = service.uuid.toString();
      // logD("所有服务值 --- $value");
      if (service.uuid.toString().toLowerCase() == bleProduct.serviceUuid) {
        logD("匹配到正确的特征值：" + bleProduct.serviceUuid);
        List<BluetoothCharacteristic> characteristics = service.characteristics;
        characteristics.forEach((characteristic) async {
          var valuex = characteristic.uuid.toString();
          // logD("所有特征值 --- $valuex");
          if (characteristic.uuid.toString().toLowerCase() ==
              bleProduct.characteristicUuid) {
            logD("匹配到正确的特征值：" + bleProduct.characteristicUuid);
            _characteristic = characteristic;
            bleProduct.device = device;
            await _receiveFromDevice();
            bleProduct.connected = true;
            _bleConnectedListener(true);
          }
        });
      }
    });
  }

  ///发送消息到设备
  ///[comm]根据具体协议生成的数据命令
  send2Device(List<int> comm) {
    //数据超过20字节，需要分包发送，插件已经做了处理
    _characteristic.write(comm);

    // if (comm.length <= 20) {
    //   _characteristic.write(comm);
    // } else {
    //
    //   _send2DevicePlus(comm);
    // }
  }

  ///数据超过20字节，分包发送
  @deprecated
  Future<void> _send2DevicePlus(List<int> comm) async {
    logD('_send2DevicePlus  start');
    final List<List<int>> comms = [];
    for (int i = 0; i < comm.length;) {
      final List<int> tem = [];
      for (int j = 0; j < 20; j++) {
        if (i < comm.length) {
          tem.add(comm[i++]);
        }
      }
      comms.add(tem);
    }
    await Future.forEach(comms, (v) async {
      logD('write  ${intList2HexStr(v)}');
      await _characteristic.write(v);
    });
    logD('_send2DevicePlus  end');
  }

  StreamSubscription _streamSubscription;

  ///接收设备发送的数据
  _receiveFromDevice() async {
    logD('_receiveFromDevice  start ');
    await _characteristic.setNotifyValue(true);
    if (_streamSubscription != null) {
      _streamSubscription.cancel();
    }
    _streamSubscription = _characteristic.value.listen((data) {
      var dataStr = intList2HexStr(data);
      logD('从蓝牙设备接收到数据： $dataStr');

      ///解析处理从设备接受到的数据
      bleProduct.parseData(data);
    });
  }
}
