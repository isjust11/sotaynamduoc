import 'package:sotaynamduoc/domain/data/models/auth_model.dart';
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
    return Future.error(apiResponse.errMessage);
  }
}
