import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  const BaseState();

  @override
  List<Object> get props => [];
}

class InitState extends BaseState {}

class LoadingState extends BaseState {}

class LoadedState<T> extends BaseState {
  final T data;
  final String msgError;
  final timeEmit;
  final bool isLocalizeMessage;

  const LoadedState(
    this.data, {
    this.msgError = "",
    this.timeEmit,
    this.isLocalizeMessage = true,
  });

  @override
  List<Object> get props => [data as Object, timeEmit ?? ""];
}

class ErrorState extends BaseState {
  final String message;
  final timeEmit;
  final bool isLocalizeMessage;

  const ErrorState(this.message, {this.isLocalizeMessage = true, this.timeEmit})
    : assert(message != null || message != "");

  @override
  List<Object> get props => [message ?? "", timeEmit ?? ""];
}

class EmptyState extends BaseState {}
