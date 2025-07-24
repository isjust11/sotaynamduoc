import 'package:sotaynamduoc/domain/data/entities/entities.dart';

import 'base_entity.dart';

class AuthEntity extends BaseEntity {
  String accessToken = '';
  String refreshToken = '';
  UserEntity? user;


  @override
  AuthEntity.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    user = UserEntity.fromJson (json['user'] as Map<String, dynamic>);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    data['user'] = user;
    return data;
  }
}
