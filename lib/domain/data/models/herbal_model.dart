import 'package:sotaynamduoc/domain/data/entities/herbal_entity.dart';
import 'package:sotaynamduoc/domain/data/entities/herbal_image_entity.dart';

class HerbalModel {
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
  String? categoryId;
  String? categoryName;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  HerbalModel({
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
    this.categoryId,
    this.categoryName,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  HerbalModel.fromJson(Map<String, dynamic> json) {
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
    categoryId = json['categoryId']?.toString();
    categoryName = json['categoryName']?.toString();
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
      final v = images!;
      final arr0 = [];
      for (var v in v) {
        arr0.add(v.toJson());
      }
      data['images'] = arr0;
    }
    
    data['viewCount'] = viewCount;
    data['likeCount'] = likeCount;
    data['authorId'] = authorId;
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  HerbalDetailEntity toEntity() {
    return HerbalDetailEntity(
      id: id,
      title: title,
      slug: slug,
      summary: summary,
      content: content,
      scientificName: scientificName,
      commonNames: commonNames,
      family: family,
      partsUsed: partsUsed,
      activeCompounds: activeCompounds,
      medicinalProperties: medicinalProperties,
      preparationMethods: preparationMethods,
      dosage: dosage,
      contraindications: contraindications,
      sideEffects: sideEffects,
      thumbnail: thumbnail,
      images: images,
      viewCount: viewCount,
      likeCount: likeCount,
      authorId: authorId,
      categoryId: categoryId,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  HerbalModel copyWith({
    String? id,
    String? title,
    String? slug,
    String? summary,
    String? content,
    String? scientificName,
    String? commonNames,
    String? family,
    String? partsUsed,
    String? activeCompounds,
    String? medicinalProperties,
    String? preparationMethods,
    String? dosage,
    String? contraindications,
    String? sideEffects,
    String? thumbnail,
    List<HerbalImageEntity>? images,
    int? viewCount,
    int? likeCount,
    String? authorId,
    String? categoryId,
    String? categoryName,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
  }) {
    return HerbalModel(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      summary: summary ?? this.summary,
      content: content ?? this.content,
      scientificName: scientificName ?? this.scientificName,
      commonNames: commonNames ?? this.commonNames,
      family: family ?? this.family,
      partsUsed: partsUsed ?? this.partsUsed,
      activeCompounds: activeCompounds ?? this.activeCompounds,
      medicinalProperties: medicinalProperties ?? this.medicinalProperties,
      preparationMethods: preparationMethods ?? this.preparationMethods,
      dosage: dosage ?? this.dosage,
      contraindications: contraindications ?? this.contraindications,
      sideEffects: sideEffects ?? this.sideEffects,
      thumbnail: thumbnail ?? this.thumbnail,
      images: images ?? this.images,
      viewCount: viewCount ?? this.viewCount,
      likeCount: likeCount ?? this.likeCount,
      authorId: authorId ?? this.authorId,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
} 