import 'package:sotaynamduoc/domain/data/entities/entities.dart';
import 'base_entity.dart';

class UserEntity extends BaseEntity {
  String? id;
  String? username;
  bool? isAdmin;
  bool? isBlock;
  String? fullName;
  String? _picture;
  String? get picture => _picture;
  set picture(String? value) {
    _picture = value;
  }

  /// Get converted picture URL for Flutter
  List<RoleEntity> roles = [];
  List<dynamic> permissions = [];
  String? email;
  String? platformId;
  String? verificationToken;
  String? pinCode;
  String? pinExpiresAt;
  String? lastLogin;
  String? createdAt;
  String? updatedAt;

  UserEntity.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    id = json['id'].toString();
    username = json['username'];
    isAdmin = json['isAdmin'];
    isBlock = json['isBlock'];
    fullName = json['fullName'];
    _picture = json['picture'];
    roles = (json['roles'] as List)
        .map((role) => RoleEntity.fromJson(role as Map<String, dynamic>))
        .toList();
    permissions = json['permissions'] ?? [];
    email = json['email'];
    platformId = json['platformId'];
    verificationToken = json['verificationToken'];
    pinCode = json['pinCode'];
    pinExpiresAt = json['pinExpiresAt'];
    lastLogin = json['lastLogin'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['username'] = username;
    data['isAdmin'] = isAdmin;
    data['isBlock'] = isBlock;
    data['fullName'] = fullName;
    data['picture'] = _picture;
    data['roles'] = roles.map((role) => role.toJson()).toList();
    data['permissions'] = permissions;
    data['email'] = email;
    data['platformId'] = platformId;
    data['verificationToken'] = verificationToken;
    data['pinCode'] = pinCode;
    data['pinExpiresAt'] = pinExpiresAt;
    data['lastLogin'] = lastLogin;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
