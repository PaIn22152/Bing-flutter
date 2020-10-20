import 'package:flutter_demo/const/constants.dart';

class ImgBean {
  static const String enddate_key = 'enddate';
  static const String url_key = 'url';
  static const String copyright_key = 'copyright';

  String enddate;
  String url;
  String copyright;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[enddate_key] = this.enddate;
    data[url_key] = this.url;
    data[copyright_key] = this.copyright;
    return data;
  }

  static ImgBean createFromMap(Map<String, dynamic> data) {
    ImgBean bean = new ImgBean();
    bean.enddate = data[enddate_key];
    bean.url = data[url_key];
    bean.copyright = data[copyright_key];
    return bean;
  }

  static ImgBean createFromJson(dynamic json) {
    ImgBean bean = new ImgBean();
    bean.enddate = json[enddate_key];
    bean.url = bingImgBaseUrl + json[url_key];
    bean.copyright = json[copyright_key];
    return bean;
  }
}
