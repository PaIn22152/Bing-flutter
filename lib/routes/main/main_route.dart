import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bing_flutter/my_all_imports.dart';
import 'package:bing_flutter/routes/main/bloc/main_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_drag_scale/flutter_drag_scale.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class MainRoute extends StatefulWidget {
  @override
  MainRouteState createState() => MainRouteState();
}

class MainRouteState extends BaseState<MainRoute> {
  bool _doubleClick = false;
  final MainBloc _mainBloc = MainBloc();

  @override
  Color bgColor() {
    return Colors.grey[600];
  }

  //菜单栏默认字体样式（大小，颜色，是否加粗等）
  TextStyle _defMenuStyle() {
    return TextStyle(
        color: Colors.blue[700], fontSize: 15.sp, fontWeight: FontWeight.bold);
  }

  void _showMenu(String url) {
    showCupertinoModalPopup<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: Text(
              homeMenuTitle,
              style: TextStyle(
                  color: Colors.grey, fontSize: 18.sp, fontFamily: 'pottaOne'),
            ),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text(
                  homeMenuHistory,
                  style: _defMenuStyle(),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  final result =
                      await Navigator.of(context).pushNamed(history_route);
                  // logD('result=$result');
                  if (result is ImgBean) {
                    _mainBloc.add(MainChangedEvent(result));
                  }
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
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(setting_route);
                },
                isDestructiveAction: true,
              ),
              CupertinoActionSheetAction(
                child: Text(
                  homeMenuDownload,
                  style: _defMenuStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _requestStorePermission(url);
                },
                isDestructiveAction: true,
              ),
              CupertinoActionSheetAction(
                child: Text(
                  homeMenuCopy,
                  style: _defMenuStyle(),
                ),
                onPressed: () {
                  if (url != null && url.isNotEmpty) {
                    Clipboard.setData(ClipboardData(text: url));
                    toast(toastCopiedUrl);
                    Navigator.of(context).pop();
                  }
                },
                isDestructiveAction: true,
              ),
              CupertinoActionSheetAction(
                child: Text(
                  '测试功能',
                  style: _defMenuStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();

                  Navigator.of(context)
                      .pushNamed(test_route, arguments: TestData(11, 'name'));
                },
                isDestructiveAction: true,
              ),
            ],
          );
        });
  }

  Future<bool> _exitApp() {
    if (_doubleClick) {
      return Future.value(true);
    } else {
      _doubleClick = true;
      Timer(const Duration(seconds: 2), () {
        _doubleClick = false;
      });
      toast(toastExitApp);
      return Future.value(false);
    }
  }

  //保存图片前，先申请存储权限
  Future _requestStorePermission(String url) async {
    await Permission.storage.request();
    if (await Permission.storage.isGranted) {
      logD('权限授权成功！');
      _saveAndUpdateSys(url, md5.convert(utf8.encode(url)).toString());
    } else {
      toast(toastNeedPermission);
    }
  }

  //保存图片并通知系统更新
  Future _saveAndUpdateSys(String url, String name) async {
    final double quality = spGetPicQuality();
    final response = await Dio()
        .get<dynamic>(url, options: Options(responseType: ResponseType.bytes));
    final dynamic result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data as List<int>),
        quality: quality.toInt(),
        name: name);
    logD('_getHttp result=$result');
    toast(toastSavedImg + (result['filePath'] as String));
  }

  @override
  void initState() {
    SystemChrome.setApplicationSwitcherDescription(
        const ApplicationSwitcherDescription(
      label: 'newnnewlab',
      primaryColor: 0xffff0000,
    ));
    super.initState();
  }

  @override
  Widget bodyWidget() {
    return BlocProvider<MainBloc>(
      create: (_) => _mainBloc..add(MainStartedEvent()),
      child: WillPopScope(
        onWillPop: _exitApp,
        child: BlocBuilder<MainBloc, MainState>(builder: (context, state) {
          if (state is MainInitialState) {
            return Container();
          }
          if (state is ImgGetInProgressState) {
            return const Center(
              child: CupertinoActivityIndicator(
                radius: 70,
              ),
            );
          }
          if (state is ImgGetSuccessState ||
              state is ImgChangedState ||
              state is ImgRefreshState) {
            return Stack(
              children: [
                DragScaleContainer(
                  doubleTapStillScale: true,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: GestureDetector(
                      onTap: () {
                        _showMenu(state.imgBean.url);
                      },
                      child: Container(
                        color: Colors.grey[850],
                        child: Center(
                          child: Hero(
                            tag: state.imgBean.enddate,
                            child: CachedNetworkImage(
                              imageUrl: state.imgBean.url,
                              placeholder: (context, url) =>
                                  const CupertinoActivityIndicator(
                                radius: 70,
                              ),
                              errorWidget: (context, url, dynamic error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
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
                      state.imgBean.copyright,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 15.sp, color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          }
          if (state is ImgGetFailureState) {
            return Center(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      _showMenu(state?.imgBean?.url);
                    },
                    child: Container(
                      color: Colors.grey[850],
                      child: Center(
                        child: Image.asset('${jpg_header}th.jpg'),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20.w, 24.w, 20.w, 24.w),
                        color: homeCopyrightBg,
                        child: Text(
                          '获取图片失败!点击重试。',
                          textAlign: TextAlign.left,
                          style:
                              TextStyle(fontSize: 15.sp, color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        _mainBloc.add(MainRefreshEvent());
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text('Error state!!!'),
          );
        }),
      ),
    );
  }
}
