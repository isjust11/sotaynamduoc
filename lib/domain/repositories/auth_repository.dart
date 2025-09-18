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

  Future<RegisterModel> register(Map<String, dynamic> param) async {
    RegisterModel authModel = await remoteDataSource.register(param);
    return authModel;
  }

  Future<UserModel?> getProfile() async {
    return await localDataSource.getUserInfo();
  }

  Future<Map<String, dynamic>> verifyPin(Map<String, dynamic> param) async {
    AuthModel authModel = await remoteDataSource.verifyPin(param);
    await localDataSource.saveTokenInfo(authModel);
    await localDataSource.saveUserInfo(authModel.user!);
    return authModel.toJson();
  }

  Future<Map<String, dynamic>> resendPin(Map<String, dynamic> param) async {
    return await remoteDataSource.resendPin(param);
  }

  Future<AuthModel> mobileSocialLogin(Map<String, dynamic> param) async {
    AuthModel authModel = await remoteDataSource.mobileSocialLogin(param);
    await localDataSource.saveTokenInfo(authModel);
    await localDataSource.saveUserInfo(authModel.user!);
    return authModel;
  }
}
