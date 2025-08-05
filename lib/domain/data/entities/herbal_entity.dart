
import 'package:sotaynamduoc/domain/data/entities/category_entity.dart';
import 'package:sotaynamduoc/domain/data/entities/herbal_image_entity.dart';

class HerbalDetailEntity {
  String? id;
  String? title;
  String? slug;
  String? summary;
  String? content;
  String? scientificName;
  String? commonNames;
  String? family;
  String? partsUsed;
  String? activeCompounds;
  String? medicinalProperties;
  String? preparationMethods;
  String? dosage;
  String? contraindications;
  String? sideEffects;
  String? thumbnail;
  List<HerbalImageEntity>? images;
  int? viewCount;
  int? likeCount;
  String? authorId;
  CategoryEntity? category;
  String? categoryId;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  HerbalDetailEntity({
    this.id,
    this.title,
    this.slug,
    this.summary,
    this.content,
    this.scientificName,
    this.commonNames,
    this.family,
    this.partsUsed,
    this.activeCompounds,
    this.medicinalProperties,
    this.preparationMethods,
    this.dosage,
    this.contraindications,
    this.sideEffects,
    this.thumbnail,
    this.images,
    this.viewCount,
    this.likeCount,
    this.authorId,
    this.category,
    this.categoryId,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });
  HerbalDetailEntity.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    title = json['title']?.toString();
    slug = json['slug']?.toString();
    summary = json['summary']?.toString();
    content = json['content']?.toString();
    scientificName = json['scientificName']?.toString();
    commonNames = json['commonNames']?.toString();
    family = json['family']?.toString();
    partsUsed = json['partsUsed']?.toString();
    activeCompounds = json['activeCompounds']?.toString();
    medicinalProperties = json['medicinalProperties']?.toString();
    preparationMethods = json['preparationMethods']?.toString();
    dosage = json['dosage']?.toString();
    contraindications = json['contraindications']?.toString();
    sideEffects = json['sideEffects']?.toString();
    thumbnail = json['thumbnail']?.toString();
  if (json['images'] != null) {
  final v = json['images'];
  final arr0 = <HerbalImageEntity>[];
  v.forEach((v) {
  arr0.add(HerbalImageEntity.fromJson(v));
  });
    images = arr0;
    }
    viewCount = json['viewCount']?.toInt();
    likeCount = json['likeCount']?.toInt();
    authorId = json['authorId']?.toString();
    category = (json['category'] != null) ? CategoryEntity.fromJson(json['category']) : null;
    categoryId = json['categoryId']?.toString();
    isActive = json['isActive'];
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['summary'] = summary;
    data['content'] = content;
    data['scientificName'] = scientificName;
    data['commonNames'] = commonNames;
    data['family'] = family;
    data['partsUsed'] = partsUsed;
    data['activeCompounds'] = activeCompounds;
    data['medicinalProperties'] = medicinalProperties;
    data['preparationMethods'] = preparationMethods;
    data['dosage'] = dosage;
    data['contraindications'] = contraindications;
    data['sideEffects'] = sideEffects;
    data['thumbnail'] = thumbnail;
    if (images != null) {
      final v = images;
      final arr0 = [];
  v?.forEach((v) {
  arr0.add(v.toJson());
  });
      data['images'] = arr0;
    }
    data['viewCount'] = viewCount;
    data['likeCount'] = likeCount;
    data['authorId'] = authorId;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['categoryId'] = categoryId;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}