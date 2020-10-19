import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/app/utils/screen_adapt.dart';
import 'package:flutter_demo/app/utils/sp_impl.dart';

class SettingRoute extends StatefulWidget {
  @override
  _SettingRouteState createState() => _SettingRouteState();
}

class _SettingRouteState extends State<SettingRoute> {
  double quality = 20;

  _updateQuality(double d) {
    setState(() {
      quality = d;
    });
  }

  _label2(int i) {}

  _label() {
    String label = "";
    if (quality >= 100) {
      label = "原图";
    } else if (quality >= 70) {
      label = "超清";
    } else if (quality >= 45) {
      label = "高清";
    } else {
      label = "清晰";
    }
    return label;
  }

  @override
  Widget build(BuildContext context) {
    spGetPicQuality().then((value) => _updateQuality(value));
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(rpx(context, 16), 0, 0, 0),
                child: Text(
                  "下载图片质量",
                  style: TextStyle(fontSize: rpx(context, 16)),
                ),
              ),
              Container(
                child: Expanded(
                  child: Slider(
                      label: _label(),
                      // label: '$quality',
                      divisions: 3,
                      min: 20,
                      max: 100,
                      value: quality,
                      onChanged: (v) {
                        spPutPicQuality(v);
                        _updateQuality(v);
                      }),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
