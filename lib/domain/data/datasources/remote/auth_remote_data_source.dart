import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/data/models/verify_pin_model.dart';
import 'package:sotaynamduoc/domain/network/network.dart';

class AuthRemoteDataSource {
  final Network network;

  AuthRemoteDataSource({required this.network});

  Future<AuthModel> login(Map<String, dynamic> param) async {
    ApiResponse apiResponse = await network.post(
      url: ApiConstant.login,
      body: param,
    );
    if (apiResponse.isSuccess) {
      return AuthModel.fromJson(apiResponse.data);
    }
    return Future.error(apiResponse.message);
  }

  Future<RegisterModel> register(Map<String, dynamic> param) async {
    ApiResponse apiResponse = await network.post(
      url: ApiConstant.register,
      body: param,
    );
    if (apiResponse.isSuccess) {
      return RegisterModel.fromJson(apiResponse.data);
    }
    return Future.error(apiResponse.message);
  }

  Future<VerifyPINModel> verifyPin(Map<String, dynamic> param) async {
    ApiResponse apiResponse = await network.post(
      url: ApiConstant.verifyPin,
      body: param,
    );
    if (apiResponse.isSuccess) {
      return VerifyPINModel.fromJson(apiResponse.data);
    }
    return Future.error(apiResponse.message);
  }

  Future<VerifyPINModel> resendPin(Map<String, dynamic> param) async {
    ApiResponse apiResponse = await network.post(
      url: ApiConstant.resendPin,
      body: param,
    );
    if (apiResponse.isSuccess) {
      return VerifyPINModel.fromJson(apiResponse.data);
    }
    return Future.error(apiResponse.message);
  }

  Future<AuthModel> mobileSocialLogin(Map<String, dynamic> param) async {
    ApiResponse apiResponse = await network.post(
      url: ApiConstant.mobileSocialLogin,
      body: param,
    );
    if (apiResponse.isSuccess) {
      return AuthModel.fromJson(apiResponse.data);
    }
    return Future.error(apiResponse.message);
  }

  Future<UserModel> updateProfile(Map<String, dynamic> param) async {
    ApiResponse apiResponse = await network.put(
      url: ApiConstant.updateProfile,
      body: param,
    );
    if (apiResponse.isSuccess) {
      return UserModel.fromJson(apiResponse.data);
    }
    return Future.error(apiResponse.message);
  }
}
