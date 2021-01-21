import 'package:bing_flutter/my_all_imports.dart';
import 'package:bing_flutter/routes/setting/bloc/setting_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingRoute extends StatefulWidget {
  @override
  _SettingRouteState createState() => _SettingRouteState();
}

class _SettingRouteState extends BaseState<SettingRoute> {
  final SettingBloc _settingBloc = SettingBloc();

  @override
  Widget bodyWidget() {
    return BlocProvider(
      create: (_) => _settingBloc..add(SettingStarted()),
      child: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          if (state is SettingInitial || state is SettingChange) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(setTitle),
              ),
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.all(20.w),
                        child: Text(
                          setImgQuality,
                          style: TextStyle(fontSize: 20.sp, color: color_theme),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20.w),
                        child: Text(
                          state.label,
                          style: TextStyle(fontSize: 20.sp, color: color_theme),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(10.w),
                    child: Slider(
                        label: state.label,
                        divisions: 3,
                        min: 20,
                        max: 100,
                        value: state.quality,
                        onChanged: (v) {
                          spPutPicQuality(v);
                          _settingBloc.add(SettingChanged(v));
                        }),
                  )
                ],
              ),
            );
          }
          return Center(
            child: Text('error state=$state'),
          );
        },
      ),
    );
  }
}

