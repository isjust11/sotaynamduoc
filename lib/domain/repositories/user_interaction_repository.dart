import 'package:sotaynamduoc/domain/data/datasources/remote/user_interaction_data_source.dart';

class UserInteractionRepository {
  final UserInteractionRemoteDataSource remoteDataSource;

  UserInteractionRepository({required this.remoteDataSource});
}
