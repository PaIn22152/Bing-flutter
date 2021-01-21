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
      final List<ImgBean> imgBean = await apiGetImgs();
      if (imgBean != null) {
        await Future.forEach(imgBean, ( ImgBean b) async {
          await ImgDBHelper.instance.insertImg(b);
        });
      }

      final ImgBean img = await ImgDBHelper.instance.getImg(myFormatDate());
      if (img != null) {
        yield ImgGetSuccess(img);
      } else {
        yield const ImgGetFailure();
      }
    } else if (event is MainChanged) {
      yield ImgChanged(event.newImg);
    }
  }
}
