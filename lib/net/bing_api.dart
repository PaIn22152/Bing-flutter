import 'package:flutter_demo/const/Constants.dart';

import 'net_manager.dart';

class BingApi {
  getUrlAndSave() async {
    var res = await NetManager.getInstance()
        .baseUrl(bingApiBaseUrl)
        .get(bingApiTailUrl);
    if (res != null && res.status) {
      var data = res.data;
      Map<String, dynamic> map = new Map<String, dynamic>.from(data);
      var map2 = map["images"];
      var map22 = map2[2];
      var map222 = map22["url"];
      return map222;
    }
    return null;
  }
}
