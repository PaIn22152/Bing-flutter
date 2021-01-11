import 'package:logger/logger.dart';

///log日志

class L {
  //判断是否是release环境，关闭log
  static const bool release_env = bool.fromEnvironment('dart.vm.product');

  static final logger = Logger(
    printer: PrettyPrinter(),
  );

  // static d(String string) {
  //   // if (release_env) {
  //   //   return;
  //   // }
  //   logger.d(string);
  // }

  static d(dynamic d) {
    logger.d(d);
  }

  static e(dynamic e) {
    // if (release_env) {
    //   return;
    // }
    logger.e(e);
  }
}
