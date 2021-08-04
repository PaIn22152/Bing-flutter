///int值转十六进制字符串
///intput  17
///output  0x11
String int2hex(int i) {
  String s = i.toRadixString(16);
  if (s.length == 1) {
    s = '0x0' + s;
  } else if (s.length == 2) {
    s = '0x' + s;
  }
  return s.toLowerCase();
}

///List<int>类型的数据转成十六进制字符串
String intList2HexStr(List<int> data) {
  final List<String> list = [];
  data.forEach((v) {
    list.add(int2hex(v));
  });
  return '$list';
}

void logD(String s) {
  print(s);
}
