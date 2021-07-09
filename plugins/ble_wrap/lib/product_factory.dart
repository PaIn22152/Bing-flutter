import 'package:ble_wrap/ble_product.dart';

import 'ble_wrap.dart';

class ProductFactory {
  static BleWrapper<BleProductOne> createBleProductOneWrapper() {
    BleWrapper<BleProductOne> bleGenerationOne = BleWrapper(BleProductOne());
    return bleGenerationOne;
  }

  static BleWrapper<BleProductTwo> createBleProductTwoWrapper() {
    BleWrapper<BleProductTwo> bleGenerationTwo = BleWrapper(BleProductTwo());
    return bleGenerationTwo;
  }
}
