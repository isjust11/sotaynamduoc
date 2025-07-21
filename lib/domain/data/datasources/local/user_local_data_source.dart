import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/utils/shared_preference.dart';

class UserLocalDataSource {
  Future<UserModel?> getUserInfo() {
    return SharedPreferenceUtil.getUserInfo();
  }

  Future<bool> saveUserInfo(UserModel userModel) async {
    try {
      return await SharedPreferenceUtil.saveUserInfo(userModel);
    } catch (e) {}
    return false;
  }
}
