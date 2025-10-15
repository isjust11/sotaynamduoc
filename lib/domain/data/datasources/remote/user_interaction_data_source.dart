import 'package:sotaynamduoc/domain/network/network.dart';

class UserInteractionRemoteDataSource {
  final Network network;

  UserInteractionRemoteDataSource({required this.network});

  // like
  Future<dynamic> like({
    required String targetType,
    required dynamic targetId,
  }) async {
    final ApiResponse apiResponse = await network.post(
      url: ApiConstant.likeUrl(targetType, targetId),
    );
    if (apiResponse.isSuccess) return apiResponse.data;
    return Future.error(apiResponse.message);
  }

  // unlike
  Future<void> unlike({
    required String targetType,
    required dynamic targetId,
  }) async {
    final ApiResponse apiResponse = await network.delete(
      url: ApiConstant.unlikeUrl(targetType, targetId),
    );
    if (apiResponse.isSuccess) return;
    return Future.error(apiResponse.message);
  }

  // bookmark
  Future<dynamic> bookmark({
    required String targetType,
    required dynamic targetId,
  }) async {
    final ApiResponse apiResponse = await network.post(
      url: ApiConstant.bookmarkUrl(targetType, targetId),
    );
    if (apiResponse.isSuccess) return apiResponse.data;
    return Future.error(apiResponse.message);
  }

  // unbookmark
  Future<void> unbookmark({
    required String targetType,
    required dynamic targetId,
  }) async {
    final ApiResponse apiResponse = await network.delete(
      url: ApiConstant.unbookmarkUrl(targetType, targetId),
    );
    if (apiResponse.isSuccess) return;
    return Future.error(apiResponse.message);
  }

  // share
  Future<dynamic> share({
    required String targetType,
    required dynamic targetId,
    String? sharePlatform,
  }) async {
    final ApiResponse apiResponse = await network.post(
      url: ApiConstant.shareUrl(targetType, targetId),
      body: sharePlatform == null ? null : {'sharePlatform': sharePlatform},
    );
    if (apiResponse.isSuccess) return apiResponse.data;
    return Future.error(apiResponse.message);
  }

  // rate
  Future<dynamic> rate({
    required String targetType,
    required dynamic targetId,
    required int rating,
  }) async {
    final ApiResponse apiResponse = await network.post(
      url: ApiConstant.rateUrl(targetType, targetId),
      body: {'rating': rating},
    );
    if (apiResponse.isSuccess) return apiResponse.data;
    return Future.error(apiResponse.message);
  }

  // follow
  Future<dynamic> follow({
    required String targetType,
    required dynamic targetId,
  }) async {
    final ApiResponse apiResponse = await network.post(
      url: ApiConstant.followUrl(targetType, targetId),
    );
    if (apiResponse.isSuccess) return apiResponse.data;
    return Future.error(apiResponse.message);
  }

  // unfollow
  Future<void> unfollow({
    required String targetType,
    required dynamic targetId,
  }) async {
    final ApiResponse apiResponse = await network.delete(
      url: ApiConstant.unfollowUrl(targetType, targetId),
    );
    if (apiResponse.isSuccess) return;
    return Future.error(apiResponse.message);
  }

  // get status
  Future<dynamic> getStatus({
    required String targetType,
    required dynamic targetId,
  }) async {
    final ApiResponse apiResponse = await network.get(
      url: ApiConstant.interactionStatusUrl(targetType, targetId),
    );
    if (apiResponse.isSuccess) return apiResponse.data;
    return Future.error(apiResponse.message);
  }

  // get stats
  Future<dynamic> getStats({
    required String targetType,
    required dynamic targetId,
  }) async {
    final ApiResponse apiResponse = await network.get(
      url: ApiConstant.interactionStatsUrl(targetType, targetId),
    );
    if (apiResponse.isSuccess) return apiResponse.data;
    return Future.error(apiResponse.message);
  }

  // get my interactions
  Future<dynamic> getMyInteractions({Map<String, dynamic>? query}) async {
    final ApiResponse apiResponse = await network.get(
      url: ApiConstant.myInteractionsUrl(query: query),
    );
    if (apiResponse.isSuccess) return apiResponse.data;
    return Future.error(apiResponse.message);
  }
}
