import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bing_flutter/app/db/beans/img_bean.dart';
import 'package:bing_flutter/app/db/img_db.dart';
import 'package:bing_flutter/app/res/colors.dart';
import 'package:bing_flutter/app/res/strings.dart';
import 'package:bing_flutter/app/utils/log.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        title: Text(historyTitle),
      ),
      body: ListView.builder(
          itemCount: imgs.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Container(
                  width: 360.w,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10.w),
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
                            width: 360.w,
                            height: 40.w,
                            color: historyDateBg,
                          ),
                          Center(
                            child: Text(
                              imgs[index].enddate,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
              onTap: () {
                L.d("onTap");
                Navigator.pop(context, imgs[index]);
              },
            );
          }),
    );
  }
}
