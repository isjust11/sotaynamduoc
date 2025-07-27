import 'package:sotaynamduoc/domain/data/entities/base_entity.dart';

class PermissionEntity extends BaseEntity {
  int? id;
  String? name = '';
  String? code = '';
  String? description;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  PermissionEntity.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  factory PermissionEntity.fromMap(Map<String, dynamic> map) {
    return PermissionEntity.fromJson(map);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'description': description,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
