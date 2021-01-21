part of 'setting_bloc.dart';

@immutable
abstract class SettingEvent {}

class SettingStarted extends SettingEvent {}

class SettingChanged extends SettingEvent {
  final double quality;

  SettingChanged(this.quality);
}
