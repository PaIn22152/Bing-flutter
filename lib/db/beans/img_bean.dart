class ImgBean {
  static const String images_key = 'images';
  static const String enddate_key = 'enddate';
  static const String url_key = 'url';
  static const String copyright_key = 'copyright';

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

  ImgBean.fromJson(dynamic json) {
    enddate = json[enddate_key];
    url = json[url_key];
    copyright = json[copyright_key];
  }

  static List<ImgBean> parseList(dynamic json) {
    final List<ImgBean> ans = [];
    json[images_key].forEach((v) {
      ans.add(ImgBean.fromJson(v));
    });
    return ans;
  }

  @override
  String toString() {
    return 'ImgBean{enddate: $enddate, url: $url, copyright: $copyright}';
  }
}
