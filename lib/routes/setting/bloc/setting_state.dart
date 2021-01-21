part of 'setting_bloc.dart';

@immutable
abstract class SettingState {
  final double quality;

  const SettingState(this.quality);

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

class SettingInitial extends SettingState {
  SettingInitial() : super(spGetPicQuality());
}

class SettingChange extends SettingState {
  const SettingChange(double quality) : super(quality);
}
