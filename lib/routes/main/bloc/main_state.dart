part of 'main_bloc.dart';

abstract class MainState {
  final ImgBean imgBean;

  const MainState(this.imgBean);
}

class MainInitial extends MainState {
  const MainInitial() : super(null);
}

///正在获取图片地址
class ImgGetInProgress extends MainState {
  const ImgGetInProgress() : super(null);
}

///获取图片地址成功
class ImgGetSuccess extends MainState {
  const ImgGetSuccess(ImgBean imgBean) : super(imgBean);
}

///获取图片地址失败
class ImgGetFailure extends MainState {
  const ImgGetFailure() : super(null);
}

///图片改变
class ImgChanged extends MainState {
  const ImgChanged(ImgBean imgBean) : super(imgBean);
}
