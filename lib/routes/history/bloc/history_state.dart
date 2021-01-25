part of 'history_bloc.dart';

@immutable
abstract class HistoryState {
  final List<ImgBean> imgs;

  const HistoryState(this.imgs);
}

class HistoryInitialState extends HistoryState {
  HistoryInitialState() : super(<ImgBean>[]);
}

class HistoryErrorState extends HistoryState {
  HistoryErrorState() : super(<ImgBean>[]);
}

class HistoryGotFromDbState extends HistoryState {
  const HistoryGotFromDbState(List<ImgBean> imgs) : super(imgs);
}
