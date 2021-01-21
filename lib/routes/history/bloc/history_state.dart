part of 'history_bloc.dart';

@immutable
abstract class HistoryState {
  final List<ImgBean> imgs;

  const HistoryState(this.imgs);
}

class HistoryInitial extends HistoryState {
  HistoryInitial() : super(<ImgBean>[]);
}

class HistoryError extends HistoryState {
  HistoryError() : super(<ImgBean>[]);
}

class HistoryGotFromDb extends HistoryState {
  const HistoryGotFromDb(List<ImgBean> imgs) : super(imgs);
}
