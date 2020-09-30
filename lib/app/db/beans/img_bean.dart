import 'package:flutter_demo/const/constants.dart';

class ImgBean {
  String enddate;
  String url;
  String copyright;

  static ImgBean create(dynamic json) {
    ImgBean bean = new ImgBean();
    bean.enddate = json["enddate"];
    bean.url = bingImgBaseUrl + json["url"];
    bean.copyright = json["copyright"];
    return bean;
  }
}
