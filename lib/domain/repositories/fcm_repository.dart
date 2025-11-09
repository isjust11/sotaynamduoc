import 'package:sotaynamduoc/domain/data/datasources/datasource.dart';
import 'package:sotaynamduoc/domain/data/datasources/remote/fcm_remote_data_source.dart';
import 'package:sotaynamduoc/domain/data/models/fcm_token_model.dart';

class FcmRepository {
  FcmRemoteDataSource remoteDataSource;
  UserLocalDataSource localDataSource;

  FcmRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<FcmTokenModel> registerFcmToken(String fcmToken) async {
    FcmTokenModel authModel = await remoteDataSource.registerFcm({});
    return authModel;
  }
}
