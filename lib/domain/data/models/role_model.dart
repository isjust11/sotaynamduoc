class RoleModel {
  final String? id;
  final String? name;
  final String? code;
  final String? description;
  final List<String> features;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  RoleModel({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    required this.features,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RoleModel.fromMap(Map<String, dynamic> map) {
    return RoleModel(
      id: map['id'],
      name: map['name'],
      code: map['code'],
      description: map['description'],
      features: List<String>.from(map['features']),
      isActive: map['isActive'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'description': description,
    };
  }
}
