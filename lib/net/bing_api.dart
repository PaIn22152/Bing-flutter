import 'package:bing_flutter/my_all_imports.dart';
import 'package:dio/dio.dart';

const String imgs_key = 'images';

Future<List<ImgBean>> getImgs() async {
  logD('getImgs start ');
  try {
    final Response response = await Dio().post(bingApiUrl);
    logD('getImgs end response=$response');
    final List<ImgBean> data = ImgBean.parseList(response.data);
    logD('getImgs end data=$data');
    return Future.value(data);
  } catch (e) {
    logD('getImgs e=$e ');
    return Future.value(null);
  }
}

Future<ImgBean> getImgsFromNet() async {
  // logD("getUrlAndSave");
  // try {
  //   var res = await NetManager.getInstance()
  //       .baseUrl(bingApiBaseUrl)
  //       .get(bingApiTailUrl);
  //   if (res != null && res.status) {
  //     dynamic data = res.data;
  //     Map<String, dynamic> map = Map<String, dynamic>.from(data as Map);
  //     dynamic images = map[imgs_key];
  //     await Future.forEach<dynamic>(images, (dynamic d) async {
  //       ImgBean b = ImgBean.createFromJson(d);
  //       await ImgDBHelper.instance.insertImg(b);
  //       logD("getUrlAndSave   instance  bean=$b");
  //     });
  //
  //     var date = formatDateNow();
  //     logD("date = $date");
  //     var img = await ImgDBHelper.instance.getImg(date);
  //     logD("img = $img");
  //     return img;
  //   }
  // } catch (e) {}
  return null;
}
