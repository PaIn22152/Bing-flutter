import 'package:bing_flutter/my_all_imports.dart';
import 'package:dio/dio.dart';

const String imgs_key = 'images';

Future<List<ImgBean>> apiGetImgs() async {
  logD('getImgs start ');
  try {
    final Response response = await Dio().post<dynamic>(bingApiUrl);
    logD('getImgs end response=$response');
    final List<ImgBean> data = ImgBean.parseList(response.data);
    logD('getImgs end data=$data');
    return Future.value(data);
  } catch (e) {
    logD('getImgs e=$e ');
    return Future.value(null);
  }
}


