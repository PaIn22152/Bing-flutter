import 'package:logger/logger.dart';

///log日志
//判断是否是release环境，关闭log
const bool release_env = bool.fromEnvironment('dart.vm.product');

final _logger = Logger(
  printer: PrettyPrinter(printTime: true),
);
const bool _SHOW_LOG = true;

//用于debug打断点
void logP() {}

void logD(dynamic d) {
  if (_SHOW_LOG) {
    _logger.d(d);
  }
}

void logE(dynamic e) {
  if (_SHOW_LOG) {
    _logger.e(e);
  }
}
