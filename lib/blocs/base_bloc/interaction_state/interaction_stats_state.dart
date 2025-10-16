import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';

class InitInteractionStatsState extends BaseState {}

class LoadingInteractionStatsState extends BaseState {}

class LoadedInteractionStatsState<T> extends BaseState {
  final T data;
  final String msgError;
  final timeEmit;
  final bool isLocalizeMessage;

  const LoadedInteractionStatsState(
    this.data, {
    this.msgError = "",
    this.timeEmit,
    this.isLocalizeMessage = true,
  });

  @override
  List<Object> get props => [data as Object, timeEmit ?? ""];
}

class ErrorInteractionStatsState extends BaseState {
  final String message;
  final timeEmit;
  final bool isLocalizeMessage;

  const ErrorInteractionStatsState(
    this.message, {
    this.isLocalizeMessage = true,
    this.timeEmit,
  }) : assert(message != null || message != "");

  @override
  List<Object> get props => [message ?? "", timeEmit ?? ""];
}

class EmptyInteractionStatsState extends BaseState {}
