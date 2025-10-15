import 'package:sotaynamduoc/domain/data/entities/base_entity.dart';
import 'package:sotaynamduoc/domain/data/entities/author_entity.dart';
import 'package:sotaynamduoc/domain/data/entities/category_entity.dart';
import 'package:sotaynamduoc/domain/data/entities/herbal_entity.dart';
import 'package:sotaynamduoc/domain/data/entities/folk_medicine_entity.dart';
import 'package:sotaynamduoc/domain/data/enums/interaction_target.dart';

class InteractionStatsEntity extends BaseEntity {
  int? id;
  InteractionTarget? targetType;
  int? targetId;

  // Optional foreign key relationships based on target type
  int? articleId;
  int? herbalId;
  int? folkMedicineId;
  int? authorId;
  int? categoryId;

  // Related entities
  AuthorEntity? author;
  CategoryEntity? category;
  HerbalDetailEntity? herbal;
  FolkMedicineEntity? folkMedicine;

  // Statistics counters
  int? likeCount;
  int? dislikeCount;
  int? bookmarkCount;
  int? shareCount;
  int? viewCount;
  int? commentCount;
  int? rateCount;
  int? followCount;

  // Average rating (for rate interactions)
  double? averageRating;

  // Total rating sum (for calculating average)
  double? totalRating;

  String? createdAt;
  String? updatedAt;

  InteractionStatsEntity.fromJson(Map<String, dynamic> json)
    : super.fromJson(json) {
    id = json['id'];
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

    // Statistics counters
    likeCount = json['likeCount'];
    dislikeCount = json['dislikeCount'];
    bookmarkCount = json['bookmarkCount'];
    shareCount = json['shareCount'];
    viewCount = json['viewCount'];
    commentCount = json['commentCount'];
    rateCount = json['rateCount'];
    followCount = json['followCount'];

    // Rating data
    averageRating = json['averageRating']?.toDouble();
    totalRating = json['totalRating']?.toDouble();

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['targetType'] = targetType?.value;
    data['targetId'] = targetId;

    // Optional foreign keys
    data['articleId'] = articleId;
    data['herbalId'] = herbalId;
    data['folkMedicineId'] = folkMedicineId;
    data['authorId'] = authorId;
    data['categoryId'] = categoryId;

    // Related entities
    data['author'] = author?.toJson();
    data['category'] = category?.toJson();
    data['herbal'] = herbal?.toJson();
    data['folkMedicine'] = folkMedicine?.toJson();

    // Statistics counters
    data['likeCount'] = likeCount;
    data['dislikeCount'] = dislikeCount;
    data['bookmarkCount'] = bookmarkCount;
    data['shareCount'] = shareCount;
    data['viewCount'] = viewCount;
    data['commentCount'] = commentCount;
    data['rateCount'] = rateCount;
    data['followCount'] = followCount;

    // Rating data
    data['averageRating'] = averageRating;
    data['totalRating'] = totalRating;

    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;

    return data;
  }
}
