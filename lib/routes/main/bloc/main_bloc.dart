import 'dart:async';

import 'package:bing_flutter/my_all_imports.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainInitial());

  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    if (event is MainStarted) {
      yield const ImgGetInProgress();
      final List<ImgBean> imgBean = await getImgs();
      await Future.forEach(imgBean, (b) async {
        await ImgDBHelper.instance.insertImg(b);
      });

      // if (imgBean != null) {
      //   yield ImgGetSuccess(imgBean);
      // } else {
      //   yield ImgGetFailure(
      //       ImgBean(formatDateNow(), testImgUrl2, testCopyRight2));
      // }
    }
  }
}
