import 'package:sotaynamduoc/domain/data/datasources/datasource.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';

class FeedbackRepository {
  final FeedbackRemoteDataSource remoteDataSource;

  FeedbackRepository({required this.remoteDataSource});

  Future<FeedbackModel> createFeedback(FeedbackModel feedbackModel) async {
    return await remoteDataSource.createFeedback(feedbackModel);
  }
}
