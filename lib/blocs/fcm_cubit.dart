import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base.dart';
import 'package:sotaynamduoc/blocs/utils.dart';
import 'package:sotaynamduoc/domain/repositories/fcm_repository.dart';

class FcmCubit extends Cubit<BaseState> {
  final FcmRepository repository;
  FcmCubit({required this.repository}) : super(InitState());

  /// Register FCM token with server
  Future<void> registerFcmToken({
    required String fcmToken,
    required String platform,
    required String deviceId,
    required String appVersion,
  }) async {
    try {
      emit(LoadingState());
      final result = await repository.registerFcmToken(
        fcmToken,
        platform,
        deviceId,
        appVersion,
      );
      emit(LoadedState(result));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  /// Subscribe to a topic
  Future<void> subscribeToTopic({required String topic}) async {
    try {
      emit(LoadingState());
      final success = await repository.subscribeToTopic(topic: topic);
      emit(LoadedState(success));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  /// Unsubscribe from a topic
  Future<void> unsubscribeFromTopic({required String topic}) async {
    try {
      emit(LoadingState());
      final success = await repository.unsubscribeFromTopic(topic: topic);
      emit(LoadedState(success));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  /// Send notification to a topic
  Future<void> sendToTopic({
    required String topic,
    required String title,
    required String body,
  }) async {
    try {
      emit(LoadingState());
      final success = await repository.sendToTopic(
        topic: topic,
        title: title,
        body: body,
      );
      emit(LoadedState(success));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  /// Send notification to a single token
  Future<void> sendToToken({
    required String token,
    required String title,
    required String body,
  }) async {
    try {
      emit(LoadingState());
      final success = await repository.sendToToken(token, title, body);
      emit(LoadedState(success));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  /// Send notification to multiple tokens
  Future<void> sendToTokens({
    required List<String> tokens,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      emit(LoadingState());
      final success = await repository.sendToTokens(tokens, title, body, data);
      emit(LoadedState(success));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }
}
