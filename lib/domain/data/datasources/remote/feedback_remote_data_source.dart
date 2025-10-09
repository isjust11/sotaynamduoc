import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/network/network.dart';

class FeedbackRemoteDataSource {
  final Network network;

  FeedbackRemoteDataSource({required this.network});

  Future<FeedbackModel> createFeedback(FeedbackModel feedbackModel) async {
    ApiResponse apiResponse = await network.post(
      url: ApiConstant.createFeedback,
      body: feedbackModel.toJson(),
    );
    if (apiResponse.isSuccess) {
      return FeedbackModel.fromJson(apiResponse.data);
    }
    return Future.error(apiResponse.message);
  }
}
