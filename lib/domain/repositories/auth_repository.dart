import 'package:sotaynamduoc/domain/data/datasources/datasource.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';

class AuthRepository {
  AuthRemoteDataSource remoteDataSource;
  UserLocalDataSource localDataSource;

  AuthRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<AuthModel> login(Map<String, dynamic> param) async {
    AuthModel authModel = await remoteDataSource.login(param);
    await localDataSource.saveTokenInfo(authModel);
    await localDataSource.saveUserInfo(authModel.user!);
    return authModel;
  }

  Future<UserModel> register(Map<String, dynamic> param) {
    // TODO: implement register
    throw UnimplementedError();
  }

  Future<UserModel?> getProfile() async {
    return await localDataSource.getUserInfo();
  }
}
