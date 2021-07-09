import 'package:ble_wrap/ble_product.dart';
import 'package:ble_wrap/util.dart';
import 'package:flutter_blue/flutter_blue.dart';

///负责蓝牙设备的搜索，连接，发送数据，接收数据
///不涉及数据的组装，解析，和设备的具体功能
///设备的具体功能，交由具体的[BleProduct]处理

FlutterBlue _flutterBlue = FlutterBlue.instance;

///蓝牙设备连接回调
typedef BleConnectListener = void Function(bool suc);

class BleWrapper<T extends BleProduct> {
  BleWrapper(this.bleProduct) {
    bleProduct.bleWrapper = this;
  }

  T bleProduct;

  BleConnectListener _bleConnectedListener;
  BluetoothCharacteristic _characteristic;

  Future<void> startScanBle(BleConnectListener listener) async {
    _bleConnectedListener = listener;
    logD('startScanBle');

    BluetoothDevice tem;
    final connectedDevices = await _flutterBlue.connectedDevices;
    connectedDevices.forEach((device) {
      if (device.name == bleProduct.bleName) {
        tem = device;
        return;
      }
    });
    if (tem != null) {
      logD('startScanBle  11  connectedDevices');

      _discoverServices(tem);
      return;
    }

    ///监听扫描设备的结果
    _flutterBlue.scanResults.listen((results) async {
      for (final ScanResult r in results) {
        if (bleProduct.bleName == r.device.name) {
          _flutterBlue.stopScan();

          _discoverServices(r.device);
        }
      }
    }, onError: _onError);

    logD('startScanBle   22  scan');

    ///开始扫描设备
    _flutterBlue.startScan(timeout: const Duration(seconds: 4));
  }

  void _onError(error) {
    logD('startScanBle  scan error=$error');
    _bleConnectedListener(false);
  }

  ///发现所有设备
  Future<void> _discoverServices(BluetoothDevice device) async {
    logD('发现设备');
    await device.connect(timeout: const Duration(seconds: 4));
    final List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) {
      var value = service.uuid.toString();
      // logD("所有服务值 --- $value");
      if (service.uuid.toString().toLowerCase() == bleProduct.serviceUuid) {
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
  Future<void> send2Device(List<int> comm) async {
    if (comm.length <= 20) {//数据字节数小于等于20，直接发送
      await _characteristic.write(comm);
    } else {
      //数据超过20字节，需要分包发送
      await _send2DevicePlus(comm);
    }
  }

  ///数据超过20字节，分包发送
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

  ///接收设备发送的数据
  Future<void> _receiveFromDevice() async {
    logD('_receiveFromDevice  start ');
    await _characteristic.setNotifyValue(true);
    _characteristic.value.listen((data) {
      final dataStr = intList2HexStr(data);
      logD('从蓝牙设备接收到数据： $dataStr');

      ///解析处理从设备接受到的数据
      bleProduct.parseData(data);
    });
  }
}
