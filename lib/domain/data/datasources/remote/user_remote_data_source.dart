import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/network/network.dart';

class UserRemoteDataSource {
  final Network network;

  UserRemoteDataSource({required this.network});

  Future<UserModel> getUserInfo() async {
    ApiResponse apiResponse = await network.get(
      url: ApiConstant.getUserInfo,
    );
    if (apiResponse.isSuccess) {
      return UserModel.fromJson(apiResponse.data);
    }
    return Future.error(apiResponse.errMessage);
  }
}
