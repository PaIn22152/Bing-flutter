import 'package:bing_flutter/my_all_imports.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryRoute extends StatefulWidget {
  @override
  _HistoryRouteState createState() => _HistoryRouteState();
}

class _HistoryRouteState extends State<HistoryRoute> {
  List<ImgBean> imgs = List();

  void _updateData(List<ImgBean> list) {
    setState(() {
      imgs = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    ImgDBHelper.instance.getImgs().then((value) => _updateData(value));
    return Scaffold(
      appBar: AppBar(
        title: const Text(historyTitle),
      ),
      body: ListView.builder(
          // physics: ClampingScrollPhysics(),
          itemCount: imgs.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Container(
                  width: 360.w,
                  height: 200.w,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10.w),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: CachedNetworkImage(
                          imageUrl: imgs[index].url,
                          placeholder: (context, url) =>
                              const CupertinoActivityIndicator(),
                          errorWidget: (context, url, dynamic error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      Container(
                        width: 360.w,
                        height: 40.w,
                        color: historyDateBg,
                        child: Center(
                          child: Text(
                            imgs[index].enddate,
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.sp),
                          ),
                        ),
                      )
                    ],
                  )),
              onTap: () {
                logD('onTap');
                Navigator.pop(context, imgs[index]);
              },
            );
          }),
    );
  }
}
