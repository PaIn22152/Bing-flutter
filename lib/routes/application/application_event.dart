part of 'application_bloc.dart';

@immutable
abstract class ApplicationEvent {}

class AppStartedEvent extends ApplicationEvent {}

class AppUpdatedEvent extends ApplicationEvent {}
