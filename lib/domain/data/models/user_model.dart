import 'package:sotaynamduoc/domain/data/entities/entities.dart';

class UserModel extends UserEntity {
  UserModel.fromJson(super.json) : super.fromJson();

  get getSortName {
    int length = username?.length ?? 0;
    if (length <= 1) {
      return username ?? "";
    } else {
      return "${username![0]}${username![length - 1]}";
    }
  }
}
