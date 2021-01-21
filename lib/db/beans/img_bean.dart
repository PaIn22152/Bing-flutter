import 'package:bing_flutter/my_all_imports.dart';

const String images_key = 'images';
const String enddate_key = 'enddate';
const String url_key = 'url';
const String copyright_key = 'copyright';

class ImgBean {
  ImgBean(this.enddate, this.url, this.copyright);

  String enddate;
  String url;
  String copyright;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[enddate_key] = this?.enddate;
    data[url_key] = this?.url;
    data[copyright_key] = this?.copyright;
    return data;
  }

  ImgBean.fromJson(dynamic json, {bool addHeader = false}) {
    enddate = json[enddate_key] as String;
    url = addHeader
        ? bingImgBaseUrl + (json[url_key] as String)
        : json[url_key] as String;
    copyright = json[copyright_key] as String;
  }

  static List<ImgBean> parseList(dynamic json) {
    final List<ImgBean> ans = [];
    json[images_key].forEach((dynamic v) {
      ans.add(ImgBean.fromJson(v, addHeader: true));
    });
    return ans;
  }

  @override
  String toString() {
    return 'ImgBean{enddate: $enddate, url: $url, copyright: $copyright}';
  }
}
