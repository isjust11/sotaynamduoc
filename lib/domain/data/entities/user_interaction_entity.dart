import 'package:sotaynamduoc/domain/data/entities/base_entity.dart';
import 'package:sotaynamduoc/domain/data/entities/user_entity.dart';
import 'package:sotaynamduoc/domain/data/entities/author_entity.dart';
import 'package:sotaynamduoc/domain/data/entities/category_entity.dart';
import 'package:sotaynamduoc/domain/data/entities/herbal_entity.dart';
import 'package:sotaynamduoc/domain/data/entities/folk_medicine_entity.dart';
import 'package:sotaynamduoc/domain/data/enums/interaction_type.dart';
import 'package:sotaynamduoc/domain/data/enums/interaction_target.dart';

class UserInteractionEntity extends BaseEntity {
  String? id;
  String? userId;
  UserEntity? user;
  InteractionType? interactionType;
  InteractionTarget? targetType;
  String? targetId;

  // Optional foreign key relationships based on target type
  String? articleId;
  String? herbalId;
  String? folkMedicineId;
  String? authorId;
  String? categoryId;

  // Related entities
  AuthorEntity? author;
  CategoryEntity? category;
  HerbalDetailEntity? herbal;
  FolkMedicineEntity? folkMedicine;

  // Additional data for specific interaction types
  Map<String, dynamic>? metadata;

  // For rating interactions
  double? rating;

  // For comment interactions
  String? comment;

  // For share interactions
  String? sharePlatform;

  String? createdAt;
  String? updatedAt;

  UserInteractionEntity.fromJson(Map<String, dynamic> json)
    : super.fromJson(json) {
    id = json['id'];
    userId = json['userId'];
    interactionType = json['interactionType'] != null
        ? InteractionType.fromString(json['interactionType'])
        : null;
    targetType = json['targetType'] != null
        ? InteractionTarget.fromString(json['targetType'])
        : null;
    targetId = json['targetId'];

    // Optional foreign keys
    articleId = json['articleId'];
    herbalId = json['herbalId'];
    folkMedicineId = json['folkMedicineId'];
    authorId = json['authorId'];
    categoryId = json['categoryId'];

    // Related entities
    if (json['user'] != null) {
      user = UserEntity.fromJson(json['user']);
    }
    if (json['author'] != null) {
      author = AuthorEntity.fromJson(json['author']);
    }
    if (json['category'] != null) {
      category = CategoryEntity.fromJson(json['category']);
    }
    if (json['herbal'] != null) {
      herbal = HerbalDetailEntity.fromJson(json['herbal']);
    }
    if (json['folkMedicine'] != null) {
      folkMedicine = FolkMedicineEntity.fromJson(json['folkMedicine']);
    }

    // Additional data
    metadata = json['metadata'];
    rating = json['rating']?.toDouble();
    comment = json['comment'];
    sharePlatform = json['sharePlatform'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['interactionType'] = interactionType?.value;
    data['targetType'] = targetType?.value;
    data['targetId'] = targetId;

    // Optional foreign keys
    data['articleId'] = articleId;
    data['herbalId'] = herbalId;
    data['folkMedicineId'] = folkMedicineId;
    data['authorId'] = authorId;
    data['categoryId'] = categoryId;

    // Related entities
    data['user'] = user?.toJson();
    data['author'] = author?.toJson();
    data['category'] = category?.toJson();
    data['herbal'] = herbal?.toJson();
    data['folkMedicine'] = folkMedicine?.toJson();

    // Additional data
    data['metadata'] = metadata;
    data['rating'] = rating;
    data['comment'] = comment;
    data['sharePlatform'] = sharePlatform;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;

    return data;
  }
}
