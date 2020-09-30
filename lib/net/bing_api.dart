import 'package:flutter_demo/app/db/beans/img_bean.dart';
import 'package:flutter_demo/const/constants.dart';

import 'net_manager.dart';

class BingApi {
  getUrlAndSave() async {
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
        }else{
          //insert db
        }
        print("object");
      }
      return img;
    }
    return null;
  }
}
