part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class ImgStarted extends MainEvent {}

class ImgGot extends MainEvent {}
