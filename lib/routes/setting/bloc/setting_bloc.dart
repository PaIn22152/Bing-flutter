import 'dart:async';

import 'package:bing_flutter/my_all_imports.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'setting_event.dart';

part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingInitialState());

  @override
  Stream<SettingState> mapEventToState(
    SettingEvent event,
  ) async* {
    if (event is SettingQualityChangedEvent) {
      yield SettingChangeQualityState(event.quality);
    } else if (event is SettingDarkThemeChangedEvent) {
      yield SettingChangeDarkThemeState(event.darkTheme);
    } else if (event is SettingFullScreenChangedEvent) {
      yield SettingChangeFullScreenState(event.fullScreen);
    }
  }
}
