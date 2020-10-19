import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/app/db/beans/img_bean.dart';
import 'package:flutter_demo/app/db/db_manager.dart';
import 'package:flutter_demo/app/my_router.dart';
import 'package:flutter_demo/app/res/strings.dart';
import 'package:flutter_demo/app/routes/history_route.dart';
import 'package:flutter_demo/app/utils/kit.dart';
import 'package:flutter_demo/app/utils/log.dart';
import 'package:flutter_demo/app/utils/sp_impl.dart';
import 'file:///D:/as/work-space/AA-git-projects/Bing-flutter-git/lib/app/res/colors.dart';
import 'package:flutter_demo/const/constants.dart';
import 'package:flutter_demo/net/bing_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  ImgBean img;

  bool toGet = true;

  _initImg() {
    if (img == null) {
      img = new ImgBean();
      img.url = testImgUrl2;
      img.copyright = testCopyRight2;
    }
  }

  _updateImg(ImgBean img) {
    setState(() {
      this.img = img;
    });
  }

  _regetUrl() {
    setState(() {
      this.toGet = true;
    });
  }

  _getUrl() async {
    if (toGet) {
      L.d(" get url start");
      var url = await BingApi.getUrlAndSave();
      toGet = false;
      _updateImg(url);
    }
  }

  ///获取手机的存储目录路径
  ///getExternalStorageDirectory() 获取的是  android 的外部存储 （External Storage）
  ///  getApplicationDocumentsDirectory 获取的是 ios 的Documents` or `Downloads` 目录
  Future<String> getPhoneLocalPath() async {
    final directory = Theme.of(context).platform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  void _downloadImg() async {
    Dio dio = Dio();
    var future = getPhoneLocalPath();
    future.then((value) {
      L.d("value=$value");
      dio.download(img.url, value + "/aaaImg/ttt.png");
    });
  }

  //保存图片前，先申请存储权限
  _requestStorePermission() async {
    await Permission.storage.request();
    if (await Permission.storage.isGranted) {
      L.d("权限授权成功！");
      _saveAndUpdateSys(img.url, md5.convert(utf8.encode(img.url)).toString());
    } else {
      toast("使用此功能需要相应权限！");
    }
  }

  //保存图片并通知系统更新
  _saveAndUpdateSys(String url, String name) async {
    var quality = await spGetPicQuality();
    var response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: quality,
        name: name);
    L.d("  _getHttp result=$result");
    toast("图片保存到：$result");
  }

  void _pickPhoto() async {
    ImagePicker picker = new ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    print("pickedFile.path=${pickedFile.path}");
  }

  //菜单栏默认字体样式（大小，颜色，是否加粗等）
  TextStyle _defMenuStyle() {
    return TextStyle(
      color: Colors.blue[700],
      fontSize: 18,
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
                  // Navigator.of(context).pushNamed(MyRouter.history);
                  var result=await Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return new HistoryRoute();
                  }));
                  // L.d("result=$reslut");
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
                  // spTestPut("sss123");
                  spTestGet().then((value) => L.d("2 sp=$value"));

                  spGetPicQuality().then((value) => L.d(" sp pic=$value"));

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
                  toast("成功复制图片地址");
                  Navigator.pop(context);
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

      toast("再按一次退出应用");
      return new Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    _initImg();
    _getUrl();
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
                padding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                color: Color(0x66666666),
                child: Text(
                  img.copyright,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
