import 'package:sotaynamduoc/domain/data/datasources/remote/news_remote_data_source.dart';
import 'package:sotaynamduoc/domain/data/datasources/remote/user_interaction_data_source.dart';
import 'package:sotaynamduoc/domain/data/models/news_model.dart';

class UserInteractionRepository {
  final UserInteractionRemoteDataSource remoteDataSource;

  UserInteractionRepository({required this.remoteDataSource});
}
