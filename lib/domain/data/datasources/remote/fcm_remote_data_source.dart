import 'package:sotaynamduoc/domain/data/models/fcm_token_model.dart';
import 'package:sotaynamduoc/domain/network/network.dart';

class FcmRemoteDataSource {
  final Network network;

  FcmRemoteDataSource({required this.network});

  Future<FcmTokenModel> registerFcm(Map<String, dynamic> param) async {
    ApiResponse apiResponse = await network.post(
      url: ApiConstant.registerFcmToken,
      body: param,
    );
    if (apiResponse.isSuccess) {
      return FcmTokenModel.fromJson(apiResponse.data);
    }
    return Future.error(apiResponse.message);
  }

  Future<bool> sendFcmToken(Map<String, dynamic> param) async {
    ApiResponse apiResponse = await network.post(
      url: ApiConstant.sendFcmToken,
      body: param,
    );
    if (apiResponse.isSuccess) {
      return apiResponse.data;
    }
    return Future.error(apiResponse.message);
  }

  Future<bool> subscribeToTopic(Map<String, dynamic> param) async {
    ApiResponse apiResponse = await network.post(
      url: ApiConstant.subscribeToTopic,
      body: param,
    );
    if (apiResponse.isSuccess) {
      return apiResponse.data;
    }
    return Future.error(apiResponse.message);
  }

  Future<bool> unsubscribeFromTopic(Map<String, dynamic> param) async {
    ApiResponse apiResponse = await network.post(
      url: ApiConstant.unsubscribeFromTopic,
      body: param,
    );
    if (apiResponse.isSuccess) {
      return apiResponse.data;
    }
    return Future.error(apiResponse.message);
  }

  Future<bool> sendToTopic(Map<String, dynamic> param) async {
    ApiResponse apiResponse = await network.post(
      url: ApiConstant.sendToTopic,
      body: param,
    );
    if (apiResponse.isSuccess) {
      return apiResponse.data;
    }
    return Future.error(apiResponse.message);
  }

  Future<bool> sendToToken(Map<String, dynamic> param) async {
    ApiResponse apiResponse = await network.post(
      url: ApiConstant.sendToToken,
      body: param,
    );
    if (apiResponse.isSuccess) {
      return apiResponse.data;
    }
    return Future.error(apiResponse.message);
  }
}
