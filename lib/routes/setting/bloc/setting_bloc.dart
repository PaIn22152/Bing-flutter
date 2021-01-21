import 'dart:async';

import 'package:bing_flutter/my_all_imports.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingInitial());

  @override
  Stream<SettingState> mapEventToState(
    SettingEvent event,
  ) async* {
    if (event is SettingChanged) {
      yield SettingChange(event.quality);
    }
  }
}
