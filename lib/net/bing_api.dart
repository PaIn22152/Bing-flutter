import 'package:flutter_demo/app/db/beans/img_bean.dart';
import 'package:flutter_demo/app/db/db_manager.dart';
import 'package:flutter_demo/app/utils/log.dart';
import 'package:flutter_demo/const/constants.dart';

import 'net_manager.dart';

class BingApi {
  static getUrlAndSave() async {
    L.d("getUrlAndSave");
    var res = await NetManager.getInstance()
        .baseUrl(bingApiBaseUrl)
        .get(bingApiTailUrl);
    if (res != null && res.status) {
      var data = res.data;
      Map<String, dynamic> map = new Map<String, dynamic>.from(data);
      var images = map["images"];
      ImgBean img;
      for (dynamic d in images) {
        if (img == null) {
          img = ImgBean.create(d);
        } else {
          //todo insert db
          int i = ReadSQL().db.hashCode;
          L.d(" db i = $i");
        }
      }
      return img;
    }
    return null;
  }
}
