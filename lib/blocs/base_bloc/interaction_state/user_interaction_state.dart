import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';

class InitUserInteractionState extends BaseState {}

class LoadingUserInteractionState extends BaseState {}

class LoadedUserInteractionState<T> extends BaseState {
  final T data;
  final String msgError;
  final timeEmit;
  final bool isLocalizeMessage;

  const LoadedUserInteractionState(
    this.data, {
    this.msgError = "",
    this.timeEmit,
    this.isLocalizeMessage = true,
  });

  @override
  List<Object> get props => [data as Object, timeEmit ?? ""];
}

class ErrorUserInteractionState extends BaseState {
  final String message;
  final timeEmit;
  final bool isLocalizeMessage;

  const ErrorUserInteractionState(
    this.message, {
    this.isLocalizeMessage = true,
    this.timeEmit,
  }) : assert(message != null || message != "");

  @override
  List<Object> get props => [message ?? "", timeEmit ?? ""];
}

class EmptyUserInteractionState extends BaseState {}
