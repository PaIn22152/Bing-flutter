import 'package:date_format/date_format.dart';
import 'package:flutter_demo/app/db/beans/img_bean.dart';
import 'package:flutter_demo/app/db/db_manager.dart';
import 'package:flutter_demo/app/db/img_db.dart';
import 'package:flutter_demo/app/utils/convertor.dart';
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
      for (dynamic d in images) {
        ImgDBHelper.instance.insertImg(ImgBean.createFromJson(d));
      }
      var date = formatDateNow();
      L.d("date = $date");
      var img = await ImgDBHelper.instance.getImg(date);
      L.d("img = $img");
      return img;
    }
    return null;
  }
}
