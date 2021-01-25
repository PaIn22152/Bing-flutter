part of 'setting_bloc.dart';

@immutable
abstract class SettingEvent {}

class SettingStartedEvent extends SettingEvent {}

class SettingQualityChangedEvent extends SettingEvent {
  final double quality;

  SettingQualityChangedEvent(this.quality);
}

class SettingDarkThemeChangedEvent extends SettingEvent {
  final bool darkTheme;

  SettingDarkThemeChangedEvent(this.darkTheme);
}

class SettingFullScreenChangedEvent extends SettingEvent {
  final bool fullScreen;

  SettingFullScreenChangedEvent(this.fullScreen);
}
