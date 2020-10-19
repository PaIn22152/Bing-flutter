import 'package:date_format/date_format.dart';

///转换器

formatDateNow() {
  return formatDateTime(DateTime.now());
}

//时间格式化，return  "20201012"
formatDateTime(DateTime time) {
  return formatDate(time, [yyyy, mm, dd]);
}
