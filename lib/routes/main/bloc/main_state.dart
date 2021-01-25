part of 'main_bloc.dart';

abstract class MainState {
  final ImgBean imgBean;

  const MainState(this.imgBean);
}

class MainInitialState extends MainState {
  const MainInitialState() : super(null);
}

///正在获取图片地址
class ImgGetInProgressState extends MainState {
  const ImgGetInProgressState() : super(null);
}

///获取图片地址成功
class ImgGetSuccessState extends MainState {
  const ImgGetSuccessState(ImgBean imgBean) : super(imgBean);
}

///获取图片地址失败
class ImgGetFailureState extends MainState {
  const ImgGetFailureState() : super(null);
}

///图片改变
class ImgChangedState extends MainState {
  const ImgChangedState(ImgBean imgBean) : super(imgBean);
}
