
import 'package:bing_flutter/my_all_imports.dart';
import 'package:bing_flutter/routes/main/bloc/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainRoute extends StatefulWidget {
  @override
  MainRouteState createState() => MainRouteState();
}

class MainRouteState extends BaseState<MainRoute> {
  @override
  Widget bodyWidget() {
    return BlocProvider<MainBloc>(
      create: (_) => MainBloc()..add(MainStarted()),
      child: BlocBuilder<MainBloc, MainState>(builder: (context, state) {
        if (state is MainInitial) {
          // context.read<MainBloc>().add(ImgStarted());
          return const Center(
            child: Text(' main init'),
          );
        }
        if (state is ImgGetInProgress) {
          return const Center(
            child: Text('正在获取图片地址'),
          );
        }
        if (state is ImgGetSuccess) {
          return Center(
            child: Text('成功获取图片地址 url=${state.imgBean.url}'),
          );
        }
        if (state is ImgGetFailure) {
          return Center(
            child: Text('获取图片地址失败 url=${state.imgBean.url}'),
          );
        }
        return const Center(
          child: Text('Error state!!!'),
        );
      }),
    );
  }
}
