import 'dart:async';

import 'package:bing_flutter/my_all_imports.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainInitialState());

  Future<ImgBean> _getImg() async {
    ImgBean img = await ImgDBHelper.instance.getImg(myFormatDate());
    if (img == null) {
      //当数据库里面没有当天的数据时，才请求网络接口
      final List<ImgBean> imgBean = await apiGetImgs();
      if (imgBean != null) {
        await Future.forEach(imgBean, (ImgBean b) async {
          await ImgDBHelper.instance.insertImg(b);
        });
      }
    }
    img = await ImgDBHelper.instance.getImg(myFormatDate());
    return img;
  }

  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    if (event is MainStartedEvent) {
      yield const ImgGetInProgressState();
      final ImgBean img = await _getImg();
      if (img != null) {
        yield ImgGetSuccessState(img);
      } else {
        yield const ImgGetFailureState();
      }
    } else if (event is MainChangedEvent) {
      yield ImgChangedState(event.newImg);
    } else if (event is MainRefreshEvent) {
      yield const ImgGetInProgressState();
      final ImgBean img = await _getImg();
      if (img != null) {
        yield ImgRefreshState(img);
      } else {
        yield const ImgGetFailureState();
      }
    }
  }
}
