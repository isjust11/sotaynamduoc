//User Model
class UserModel {
  final String id;
  final String username;
  final String email;
  final String fullName;
  final String lastLogin;
  final String createdAt;
  final String updatedAt;

  UserModel(
      {required this.id,
      required this.username,
      required this.email,
      required this.fullName,
      required this.lastLogin,
      required this.createdAt,
      required this.updatedAt});

  factory UserModel.fromMap(Map data) {
    return UserModel(
      id: data['id'],
      username: data['username'],
      email: data['email'],
      fullName: data['fullName'],
      lastLogin: data['lastLogin'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt']
    );
  }

  Map<String, dynamic> toJson() =>
          {"id": id, "username": username, "email": email, "fullName": fullName, "lastLogin": lastLogin, "createdAt": createdAt, "updatedAt": updatedAt};
    }
