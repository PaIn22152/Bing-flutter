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
import 'package:flutter_demo/app/my_router.dart';
import 'package:flutter_demo/app/routes/setting_route.dart';
import 'package:flutter_demo/app/utils/Log.dart';
import 'package:flutter_demo/const/constants.dart';
import 'package:flutter_demo/net/bing_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  ImgBean img;

  bool toGet = true;

  final BingApi bingApi = new BingApi();

  void _initImg() {
    if (img == null) {
      img = new ImgBean();
      img.url = testImgUrl2;
      img.copyright = testCopyRight2;
    }
  }

  void _updateUrl(ImgBean img) {
    setState(() {
      this.img = img;
    });
  }

  void _regetUrl() {
    setState(() {
      this.toGet = true;
    });
  }

  void _getUrl() async {
    if (toGet) {
      L.d(" get url start");
      var url = await bingApi.getUrlAndSave();
      _updateUrl(url);
      toGet = false;
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

  //保存图片并通知系统更新
  _saveAndUpdateSys(String url, String name) async {
    var response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 100,
        name: name);
    L.d("  _getHttp result=$result");
    _toast("图片保存到：$result");
  }

  void _toast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _takePhoto() async {
    ImagePicker picker = new ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    print("pickedFile.path=${pickedFile.path}");
  }

  void _showMenu() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            actions: <Widget>[
              // CupertinoActionSheetAction(
              //   child: Text(
              //     '查看历史图片',
              //     style: TextStyle(
              //       color: Colors.blue[700],
              //       fontSize: 20,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              //   onPressed: () {
              //     _takePhoto();
              //   },
              //   isDefaultAction: true,
              // ),
              CupertinoActionSheetAction(
                child: Text(
                  '设置',
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  L.e("test e");
                  L.d("test d");
                  Navigator.pop(context);
                  // _regetUrl();
                  Navigator.of(context).pushNamed(MyRouter.setting);
                },
                isDestructiveAction: true,
              ),
              CupertinoActionSheetAction(
                child: Text(
                  '下载图片到本地',
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _saveAndUpdateSys(
                      img.url, md5.convert(utf8.encode(img.url)).toString());
                },
                isDestructiveAction: true,
              ),
              CupertinoActionSheetAction(
                child: Text(
                  '复制图片地址',
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: img.url));
                  _toast("成功复制图片地址");
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
      Future.delayed(Duration(seconds: 2), () {
        doubleClick = false;
      });
      _toast("再按一次退出应用");
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
