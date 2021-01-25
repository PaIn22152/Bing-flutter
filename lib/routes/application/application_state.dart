part of 'application_bloc.dart';

@immutable
abstract class ApplicationState {}

class ApplicationInitialState extends ApplicationState {}

class ApplicationUpdateState extends ApplicationState {}
