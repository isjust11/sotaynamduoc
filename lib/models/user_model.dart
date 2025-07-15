//User Model
import 'package:sotaynamduoc/models/permission_model.dart';
import 'package:sotaynamduoc/models/role_model.dart';

class UserModel {
  final String id;
  final String username;
  final String email;
  final String fullName;
  final String lastLogin;
  final String createdAt;
  final String updatedAt;
  final bool isAdmin;
  final bool isBlocked;
  final bool isGoogleUser;
  final bool isFacebookUser;
  final bool isAppleUser;
  final bool isWebsiteUser;
  final bool isEmailVerified;
  final String verificationToken;
  final List<RoleModel> roles;
  final List<PermissionModel> permissions;

  UserModel(
      {required this.id,
      required this.username,
      required this.email,
      required this.fullName,
      required this.lastLogin,
      required this.createdAt,
      required this.updatedAt,
      required this.isAdmin,
      required this.isBlocked,
      required this.isGoogleUser,
      required this.isFacebookUser,
      required this.isAppleUser,
      required this.isWebsiteUser,
      required this.isEmailVerified,
      required this.verificationToken,
      required this.roles,
      required this.permissions});

  factory UserModel.fromMap(Map data) {
    return UserModel(
      id: data['id'],
      username: data['username'],
      email: data['email'],
      fullName: data['fullName'],
      lastLogin: data['lastLogin'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
      isAdmin: data['isAdmin'],
      isBlocked: data['isBlocked'],
      isGoogleUser: data['isGoogleUser'],
      isFacebookUser: data['isFacebookUser'],
      isAppleUser: data['isAppleUser'],
      isWebsiteUser: data['isWebsiteUser'],
      isEmailVerified: data['isEmailVerified'],
      verificationToken: data['verificationToken'],
      roles: data['roles'],
      permissions: data['permissions'],
    );
  }

  Map<String, dynamic> toJson() =>
          {"id": id, "username": username, "email": email, "fullName": fullName, "lastLogin": lastLogin,
           "createdAt": createdAt, "updatedAt": updatedAt, "isAdmin": isAdmin, "isBlocked": isBlocked,
            "isGoogleUser": isGoogleUser, "isFacebookUser": isFacebookUser, "isAppleUser": isAppleUser,
             "isWebsiteUser": isWebsiteUser, "isEmailVerified": isEmailVerified, "verificationToken": verificationToken,
              "roles": roles.map((role) => role.toMap()).toList(), "permissions": permissions.map((permission) => permission.toMap()).toList()};
    }
