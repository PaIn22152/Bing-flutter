import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bing_flutter/app/db/beans/img_bean.dart';
import 'package:bing_flutter/app/my_router.dart';
import 'package:bing_flutter/app/res/colors.dart';
import 'package:bing_flutter/app/res/strings.dart';
import 'package:bing_flutter/app/routes/history_route.dart';
import 'package:bing_flutter/app/utils/convertor.dart';
import 'package:bing_flutter/app/utils/kit.dart';
import 'package:bing_flutter/app/utils/log.dart';
import 'package:bing_flutter/app/utils/sp_impl.dart';
import 'package:bing_flutter/const/constants.dart';
import 'package:bing_flutter/net/bing_api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  ImgBean img;

  bool toGet = true;

  _initImg() {
    // ??= 赋值运算符，当变量的值为null时，执行赋值语句，否则不赋值
    img ??= ImgBean(formatDateNow(), testImgUrl2, testCopyRight2);
  }

  _updateImg(ImgBean img) {
    if (img != null) {
      setState(() {
        this.img = img;
      });
    }
  }

  _regetUrl() {
    setState(() {
      this.toGet = true;
    });
  }

  _getUrl() async {
    if (toGet) {

      L.d(" get url start");
      var url = await getImgsFromNet();
      toGet = false;
      _updateImg(url);
    }
  }

  //保存图片前，先申请存储权限
  _requestStorePermission() async {
    await Permission.storage.request();
    if (await Permission.storage.isGranted) {
      L.d("权限授权成功！");
      _saveAndUpdateSys(img.url, md5.convert(utf8.encode(img.url)).toString());
    } else {
      toast(toastNeedPermission);
    }
  }

  //保存图片并通知系统更新
  _saveAndUpdateSys(String url, String name) async {
    double quality = await spGetPicQuality();
    var response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: quality.toInt(),
        name: name);
    L.d("  _getHttp result=$result");
    toast(toastSavedImg + result);
  }

  //菜单栏默认字体样式（大小，颜色，是否加粗等）
  TextStyle _defMenuStyle() {
    return TextStyle(
      color: Colors.blue[700],
      fontSize: 18.sp,
      // fontWeight: FontWeight.bold,
    );
  }

  _showMenu() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: Text(
              homeMenuTitle,
              // style: _defMenuStyle(),
            ),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text(
                  homeMenuHistory,
                  style: _defMenuStyle(),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  // var reslut = await Navigator.of(context).pushNamed(MyRouter.history);
                  // L.d("result=$reslut");
                  // Navigator.of(context)
                  //     .pushNamed(MyRouter.history)
                  //     .then((value) => {
                  //       L.d("value=$value")}
                  //       );
                  var result = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return new HistoryRoute();
                  }));
                  _updateImg(result);
                },
                // isDefaultAction: true,
                isDestructiveAction: true,
              ),
              CupertinoActionSheetAction(
                child: Text(
                  homeMenuSet,
                  style: _defMenuStyle(),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  // _regetUrl();
                  Navigator.of(context).pushNamed(MyRouter.setting);
                },
                isDestructiveAction: true,
              ),
              CupertinoActionSheetAction(
                child: Text(
                  homeMenuDownload,
                  style: _defMenuStyle(),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _requestStorePermission();
                },
                isDestructiveAction: true,
              ),
              CupertinoActionSheetAction(
                child: Text(
                  homeMenuCopy,
                  style: _defMenuStyle(),
                ),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: img.url));
                  toast(toastCopiedUrl);
                  Navigator.pop(context);
                },
                isDestructiveAction: true,
              ),
              CupertinoActionSheetAction(
                child: Text(
                  '测试功能',
                  style: _defMenuStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(MyRouter.test);
                },
                isDestructiveAction: true,
              ),
            ],
          );
        });
  }

  bool doubleClick = false;

  Future<bool> _exitApp() {
    if (doubleClick) {
      return new Future.value(true);
    } else {
      doubleClick = true;

      //延时
      Timer(Duration(seconds: 2), () {
        doubleClick = false;
      });
      //效果同上，而且也是使用timer实现的
      // Future.delayed(Duration(seconds: 2), () {
      //   doubleClick = false;
      // });

      //轮询
      // var num = 0;
      // Timer.periodic(Duration(seconds: 1), (timer) {
      //   L.d("periodic num=$num");
      //   num++;
      //   if (num >= 5) {
      //     timer.cancel();
      //   }
      // });

      toast(toastExitApp);
      return new Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    _initImg();
    _getUrl();

    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸)
    ScreenUtil.init(context,
        designSize: Size(360, 640), allowFontScaling: true);

    return WillPopScope(
      onWillPop: () => _exitApp(),
      child: Scaffold(
        body: Stack(
          children: [
            GestureDetector(
              onTap: () {
                _showMenu();
              },
              child: Container(
                color: Colors.grey[850],
                child: Center(
                  // child: Image.network(img.url),
                  child: CachedNetworkImage(
                    imageUrl: img.url,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(20.w, 24.w, 20.w, 24.w),
                color: homeCopyrightBg,
                child: Text(
                  img.copyright,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15.sp, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
