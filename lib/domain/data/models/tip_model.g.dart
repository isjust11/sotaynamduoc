// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TipModel _$TipModelFromJson(Map<String, dynamic> json) => TipModel(
  id: json['id'] as String?,
  title: json['title'] as String?,
  content: json['content'] as String?,
  summary: json['summary'] as String?,
  thumbnail: json['thumbnail'] as String?,
  category: json['category'] as String?,
  author: json['author'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  viewCount: json['viewCount'] as int?,
  likeCount: json['likeCount'] as int?,
  bookmarkCount: json['bookmarkCount'] as int?,
  isLiked: json['isLiked'] as bool?,
  isBookmarked: json['isBookmarked'] as bool?,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  difficulty: json['difficulty'] as String?,
  estimatedTime: json['estimatedTime'] as String?,
  targetAudience: json['targetAudience'] as String?,
  relatedTips: (json['relatedTips'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  source: json['source'] as String?,
  videoUrl: json['videoUrl'] as String?,
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$TipModelToJson(TipModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'content': instance.content,
  'summary': instance.summary,
  'thumbnail': instance.thumbnail,
  'category': instance.category,
  'author': instance.author,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'viewCount': instance.viewCount,
  'likeCount': instance.likeCount,
  'bookmarkCount': instance.bookmarkCount,
  'isLiked': instance.isLiked,
  'isBookmarked': instance.isBookmarked,
  'tags': instance.tags,
  'difficulty': instance.difficulty,
  'estimatedTime': instance.estimatedTime,
  'targetAudience': instance.targetAudience,
  'relatedTips': instance.relatedTips,
  'source': instance.source,
  'videoUrl': instance.videoUrl,
  'images': instance.images,
};

TipCategory _$TipCategoryFromJson(Map<String, dynamic> json) => TipCategory(
  id: json['id'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
  icon: json['icon'] as String?,
  color: json['color'] as String?,
  tipCount: json['tipCount'] as int?,
);

Map<String, dynamic> _$TipCategoryToJson(TipCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'icon': instance.icon,
      'color': instance.color,
      'tipCount': instance.tipCount,
    };
