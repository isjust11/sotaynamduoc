import 'package:sotaynamduoc/domain/data/entities/role_entity.dart';

import 'base_entity.dart';

class UserEntity extends BaseEntity {
  int? id;
  String? username;
  bool? isAdmin;
  bool? isBlock;
  String? fullName;
  String? picture;
  List<RoleEntity> roles=[];


  @override
  UserEntity.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    id = json['id'];
    username = json['username'];
    isAdmin = json['isAdmin'];
    isBlock = json['isBlock'];
    fullName = json['fullName'];
    picture = json['picture'];
    roles = (json['roles'] as dynamic)
    .map((role)=> RoleEntity.fromJson(role as Map<String, dynamic>));

  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}
