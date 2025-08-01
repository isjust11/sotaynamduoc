import 'package:sotaynamduoc/domain/data/entities/folk_medicine_entity.dart';
import 'package:sotaynamduoc/domain/data/models/category_model.dart';

class FolkMedicineModel extends FolkMedicineEntity {
  FolkMedicineModel({
    super.id,
    super.title,
    super.slug,
    super.summary,
    super.content,
    super.ingredients,
    super.preparation,
    super.usage,
    super.notes,
    super.thumbnail,
    super.viewCount,
    super.likeCount,
    super.authorId,
    super.category,
    super.categoryId,
    super.isActive,
    super.createdAt,
    super.updatedAt,
  });

  factory FolkMedicineModel.fromJson(Map<String, dynamic> json) {
    return FolkMedicineModel(
      id: json['id']?.toString(),
      title: json['title']?.toString(),
      slug: json['slug']?.toString(),
      summary: json['summary']?.toString(),
      content: json['content']?.toString(),
      ingredients: json['ingredients']?.toString(),
      preparation: json['preparation']?.toString(),
      usage: json['usage']?.toString(),
      notes: json['notes']?.toString(),
      thumbnail: json['thumbnail']?.toString(),
      viewCount: json['viewCount']?.toInt(),
      likeCount: json['likeCount']?.toInt(),
      authorId: json['authorId']?.toString(),
      category: (json['category'] != null) 
          ? CategoryModel.fromJson(json['category']) 
          : null,
      categoryId: json['categoryId']?.toString(),
      isActive: json['isActive'],
      createdAt: json['createdAt']?.toString(),
      updatedAt: json['updatedAt']?.toString(),
    );
  }

  factory FolkMedicineModel.fromEntity(FolkMedicineEntity entity) {
    return FolkMedicineModel(
      id: entity.id,
      title: entity.title,
      slug: entity.slug,
      summary: entity.summary,
      content: entity.content,
      ingredients: entity.ingredients,
      preparation: entity.preparation,
      usage: entity.usage,
      notes: entity.notes,
      thumbnail: entity.thumbnail,
      viewCount: entity.viewCount,
      likeCount: entity.likeCount,
      authorId: entity.authorId,
      category: entity.category != null 
          ? CategoryModel.fromEntity(entity.category!) 
          : null,
      categoryId: entity.categoryId,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  FolkMedicineEntity toEntity() {
    return FolkMedicineEntity(
      id: id,
      title: title,
      slug: slug,
      summary: summary,
      content: content,
      ingredients: ingredients,
      preparation: preparation,
      usage: usage,
      notes: notes,
      thumbnail: thumbnail,
      viewCount: viewCount,
      likeCount: likeCount,
      authorId: authorId,
      category: category,
      categoryId: categoryId,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
} 