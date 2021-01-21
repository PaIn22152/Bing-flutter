part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent {}

class HistoryStarted extends HistoryEvent {}