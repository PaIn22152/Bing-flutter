part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class MainStartedEvent extends MainEvent {}

class MainRefreshEvent extends MainEvent {}

class MainChangedEvent extends MainEvent {
  final ImgBean newImg;

  MainChangedEvent(this.newImg);
}
