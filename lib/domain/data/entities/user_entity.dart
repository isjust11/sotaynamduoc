import 'package:sotaynamduoc/domain/data/entities/entities.dart';

import 'base_entity.dart';

class UserEntity extends BaseEntity {
  int? id;
  String? username;
  bool? isAdmin;
  bool? isBlock;
  String? fullName;
  String? picture;
  List<RoleEntity> roles = [];
  List<PermissionEntity> permissions = [];
  @override
  UserEntity.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    id = json['id'];
    username = json['username'];
    isAdmin = json['isAdmin'];
    isBlock = json['isBlock'];
    fullName = json['fullName'];
    picture = json['picture'];
    roles = (json['roles'] as List)
        .map((role) => RoleEntity.fromJson(role as Map<String, dynamic>))
        .toList();
    permissions = (json['permissions'] as List)
        .map((permission) => PermissionEntity.fromJson(permission as Map<String, dynamic>))
        .toList();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['isAdmin'] = isAdmin;
    data['isBlock'] = isBlock;
    data['fullName'] = fullName;
    data['picture'] = picture;
    data['roles'] = roles.map((role) => role.toJson()).toList();
    data['permissions'] = permissions.map((permission) => permission.toJson()).toList();
    return data;
  }
}
