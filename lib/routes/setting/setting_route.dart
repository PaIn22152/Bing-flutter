import 'package:bing_flutter/my_all_imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingRoute extends StatefulWidget {
  @override
  _SettingRouteState createState() => _SettingRouteState();
}

class _SettingRouteState extends State<SettingRoute> {
  double quality = spGetPicQuality();

  void _updateQuality(double d) {
    setState(() {
      quality = d;
    });
  }

  String _label() {
    String label = '';
    if (quality >= 100) {
      label = setLabel_1;
    } else if (quality >= 70) {
      label = setLabel_2;
    } else if (quality >= 45) {
      label = setLabel_3;
    } else {
      label = setLabel_4;
    }
    return label;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(setTitle),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(16.w, 0, 0, 0),
                child: Text(
                  setImgQuality,
                  style: TextStyle(fontSize: 16.sp),
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
