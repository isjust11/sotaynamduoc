import 'package:sotaynamduoc/domain/data/datasources/datasource.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';

class AuthRepository {
  AuthRemoteDataSource remoteDataSource;
  UserLocalDataSource localDataSource;

  AuthRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<UserModel> login(Map<String, dynamic> param) async {
    UserModel userModel = await remoteDataSource.login(param);
    await localDataSource.saveUserInfo(userModel);
    return userModel;
  }

  Future<UserModel> register(Map<String, dynamic> param) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
