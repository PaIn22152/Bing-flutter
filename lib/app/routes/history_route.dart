import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/app/db/beans/img_bean.dart';
import 'package:flutter_demo/app/db/img_db.dart';
import 'package:flutter_demo/app/res/colors.dart';
import 'package:flutter_demo/app/utils/log.dart';
import 'package:flutter_demo/app/utils/screen_adapt.dart';

class HistoryRoute extends StatefulWidget {
  @override
  _HistoryRouteState createState() => _HistoryRouteState();
}

class _HistoryRouteState extends State<HistoryRoute> {
  List<ImgBean> imgs = List();

  _updateData(List<ImgBean> list) {
    setState(() {
      imgs = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    ImgDBHelper.instance.getImgs().then((value) => _updateData(value));
    return Scaffold(
      appBar: AppBar(
        title: Text("历史图片"),
      ),
      body: ListView.builder(
          itemCount: imgs.length,
          // itemExtent: 50.0, //强制高度为50.0
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, rpx(context, 10)),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Center(
                          // child: Image.network(img.url),
                          child: CachedNetworkImage(
                            imageUrl: imgs[index].url,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            width: rpx(context, 360),
                            height: rpx(context, 40),
                            color: historyDateBg,
                          ),
                          Center(
                            child: Text(
                              imgs[index].enddate,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: rpx(context, 15)),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
              onTap: () {
                L.d("onTap");
                Navigator.pop(context, imgs[index]);
                // Navigator.of(context).pop("testrrrr");
                // Navigator.of(context).pop();
              },
            );
          }),
    );
  }
}
