import 'package:sotaynamduoc/domain/data/datasources/datasource.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/data/models/verify_pin_model.dart';

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

  Future<VerifyPINModel> verifyPin(Map<String, dynamic> param) async {
    VerifyPINModel authModel = await remoteDataSource.verifyPin(param);
    return authModel;
  }

  Future<VerifyPINModel> resendPin(Map<String, dynamic> param) async {
    VerifyPINModel authModel = await remoteDataSource.resendPin(param);
    return authModel;
  }

  Future<AuthModel> mobileSocialLogin(Map<String, dynamic> param) async {
    AuthModel authModel = await remoteDataSource.mobileSocialLogin(param);
    await localDataSource.saveTokenInfo(authModel);
    await localDataSource.saveUserInfo(authModel.user!);
    return authModel;
  }

  Future<UserModel> updateProfile(Map<String, dynamic> param) async {
    UserModel userModel = await remoteDataSource.updateProfile(param);
    await localDataSource.saveUserInfo(userModel);
    return userModel;
  }
}
