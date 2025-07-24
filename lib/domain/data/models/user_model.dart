import 'package:sotaynamduoc/domain/data/entities/entities.dart';

class UserModel extends UserEntity {
  UserModel.fromJson(super.json) : super.fromJson();

  get getSortName {
    int length = userName?.length ?? 0;
    if (length <= 1) {
      return userName ?? "";
    } else {
      return "${userName![0]}${userName![length - 1]}";
    }
  }
}
