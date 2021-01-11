import 'package:bing_flutter/app/db/beans/img_bean.dart';
import 'package:bing_flutter/app/db/img_db.dart';
import 'package:bing_flutter/app/utils/convertor.dart';
import 'package:bing_flutter/app/utils/log.dart';
import 'package:bing_flutter/const/constants.dart';

import 'net_manager.dart';

const String imgs_key = 'images';

getImgsFromNet() async {
  L.d("getUrlAndSave");
  var res = await NetManager.getInstance()
      .baseUrl(bingApiBaseUrl)
      .get(bingApiTailUrl);
  if (res != null && res.status) {
    var data = res.data;
    Map<String, dynamic> map = new Map<String, dynamic>.from(data);
    var images = map[imgs_key];
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
