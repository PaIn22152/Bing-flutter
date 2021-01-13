import 'package:bing_flutter/my_all_imports.dart';

const String imgs_key = 'images';

Future<ImgBean> getImgsFromNet() async {
  logD("getUrlAndSave");
  var res = await NetManager.getInstance()
      .baseUrl(bingApiBaseUrl)
      .get(bingApiTailUrl);
  if (res != null && res.status) {
    dynamic data = res.data;
    Map<String, dynamic> map =  Map<String, dynamic>.from(data as Map);
    dynamic images = map[imgs_key];
    await Future.forEach<dynamic>(images, (dynamic d) async {
      ImgBean b = ImgBean.createFromJson(d);
      await ImgDBHelper.instance.insertImg(b);
      logD("getUrlAndSave   instance  bean=$b");
    });

    var date = formatDateNow();
    logD("date = $date");
    var img = await ImgDBHelper.instance.getImg(date);
    logD("img = $img");
    return img;
  }
  return null;
}
