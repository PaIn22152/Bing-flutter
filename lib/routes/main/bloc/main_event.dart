part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class MainStarted extends MainEvent {}

class MainChanged extends MainEvent {
  final ImgBean newImg;

  MainChanged(this.newImg);
}
