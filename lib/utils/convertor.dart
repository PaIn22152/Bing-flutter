import 'package:date_format/date_format.dart';

///转换器

///时间格式化，return  "20201012"
String myFormatDate({DateTime time}) {
  time ??= DateTime.now();
  return formatDate(time, [yyyy, mm, dd]);
}
