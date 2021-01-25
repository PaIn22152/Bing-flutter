part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent {}

class HistoryStartedEvent extends HistoryEvent {}