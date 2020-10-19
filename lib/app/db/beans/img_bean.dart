import 'package:flutter_demo/const/constants.dart';

class ImgBean {
  String enddate;
  String url;
  String copyright;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enddate'] = this.enddate;
    data['url'] = this.url;
    data['copyright'] = this.copyright;
    return data;
  }

  static ImgBean createFromMap(Map<String, dynamic> data) {
    ImgBean bean = new ImgBean();
    bean.enddate = data['enddate'];
    bean.url = data['url'];
    bean.copyright = data['copyright'];
    return bean;
  }

  static ImgBean createFromJson(dynamic json) {
    ImgBean bean = new ImgBean();
    bean.enddate = json["enddate"];
    bean.url = bingImgBaseUrl + json["url"];
    bean.copyright = json["copyright"];
    return bean;
  }
}
