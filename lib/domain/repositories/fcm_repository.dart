import 'package:sotaynamduoc/domain/data/datasources/remote/fcm_remote_data_source.dart';
import 'package:sotaynamduoc/domain/data/models/fcm_token_model.dart';

class FcmRepository {
  FcmRemoteDataSource remoteDataSource;

  FcmRepository({required this.remoteDataSource});

  Future<FcmTokenModel> registerFcmToken(
    String fcmToken,
    String platform,
    String deviceId,
    String appVersion,
  ) async {
    FcmTokenModel fcmTokenModel = await remoteDataSource.registerFcm({
      'token': fcmToken,
      'platform': platform,
      'deviceId': deviceId,
      'app_version': appVersion,
    });
    return fcmTokenModel;
  }

  Future<bool> subscribeToTopic({required String topic}) async {
    try {
      await remoteDataSource.subscribeToTopic({'topic': topic});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> unsubscribeFromTopic({required String topic}) async {
    try {
      await remoteDataSource.unsubscribeFromTopic({'topic': topic});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> sendToTopic({
    required String topic,
    required String title,
    required String body,
  }) async {
    bool success = await remoteDataSource.sendToTopic({
      'topic': topic,
      'title': title,
      'body': body,
    });
    return success;
  }

  Future<bool> sendToToken(String token, String title, String body) async {
    bool success = await remoteDataSource.sendToToken({
      'token': token,
      'title': title,
      'body': body,
    });
    return success;
  }

  Future<bool> sendToTokens(
    List<String> tokens,
    String title,
    String body,
    Map<String, dynamic>? data,
  ) async {
    bool success = await remoteDataSource.sendToToken({
      'tokens': tokens,
      'title': title,
      'body': body,
    });
    return success;
  }
}
