import 'package:bing_flutter/const/constants.dart';

class ImgBean {
  static const String enddate_key = 'enddate';
  static const String url_key = 'url';
  static const String copyright_key = 'copyright';

  ImgBean(this.enddate, this.url, this.copyright);

  ImgBean.emptyBean();

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
    ImgBean bean = ImgBean.emptyBean();
    bean.enddate = data[enddate_key];
    bean.url = data[url_key];
    bean.copyright = data[copyright_key];
    return bean;
  }

  static ImgBean createFromJson(dynamic json) {
    ImgBean bean = ImgBean.emptyBean();
    bean.enddate = json[enddate_key];
    bean.url = bingImgBaseUrl + json[url_key];
    bean.copyright = json[copyright_key];
    return bean;
  }

  @override
  String toString() {
    return 'ImgBean{enddate: $enddate, url: $url, copyright: $copyright}';
  }
}
