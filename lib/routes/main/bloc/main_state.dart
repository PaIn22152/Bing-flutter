part of 'main_bloc.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}

///正在获取图片地址
class ImgGetInProgress extends MainState {}

///获取图片地址成功
class ImgGetSuccess extends MainState {}

///获取图片地址失败
class ImgGetFailure extends MainState {}
