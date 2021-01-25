part of 'setting_bloc.dart';

@immutable
abstract class SettingState {
  final double quality;
  final bool darkTheme;
  final bool fullScreen;

  const SettingState(this.quality, this.darkTheme, this.fullScreen);

  String get label {
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
}

class SettingInitialState extends SettingState {
  SettingInitialState()
      : super(spGetPicQuality(), spGetDarkTheme(), spGetFullScreen());
}

class SettingChangeQualityState extends SettingState {
  SettingChangeQualityState(double quality)
      : super(quality, spGetDarkTheme(), spGetFullScreen());
}

class SettingChangeDarkThemeState extends SettingState {
  SettingChangeDarkThemeState(bool darkTheme)
      : super(spGetPicQuality(), darkTheme, spGetFullScreen());
}

class SettingChangeFullScreenState extends SettingState {
  SettingChangeFullScreenState(bool fullScreen)
      : super(spGetPicQuality(), spGetDarkTheme(), fullScreen);
}
