import 'package:sotaynamduoc/domain/data/models/user_model.dart';

import 'base_entity.dart';

class RegisterEntity extends BaseEntity {
  String code = '';
  String message = '';
  UserModel? user;


  @override
  RegisterEntity.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    code = json['code'];
    message = json['message'];
    user = UserModel.fromJson (json['data'] as Map<String, dynamic>);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['data'] = user;
    return data;
  }
}
