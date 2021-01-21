import 'dart:async';

import 'package:bing_flutter/my_all_imports.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial());

  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    if (event is HistoryStarted) {
      final List<ImgBean> imgs = await ImgDBHelper.instance.getImgs();
      if (imgs != null) {
        yield HistoryGotFromDb(imgs);
      }

      ///todo for test
      // await Future<dynamic>.delayed(const Duration(seconds: 10));
      // yield HistoryError();
    }
  }
}
