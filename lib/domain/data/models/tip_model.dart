import 'package:json_annotation/json_annotation.dart';

part 'tip_model.g.dart';

@JsonSerializable()
class TipModel {
  final String? id;
  final String? title;
  final String? content;
  final String? summary;
  final String? thumbnail;
  final String? category;
  final String? author;
  final String? createdAt;
  final String? updatedAt;
  final int? viewCount;
  final int? likeCount;
  final int? bookmarkCount;
  final bool? isLiked;
  final bool? isBookmarked;
  final List<String>? tags;
  final String? difficulty; // easy, medium, hard
  final String? estimatedTime; // 5 phút, 10 phút, etc.
  final String? targetAudience; // beginner, intermediate, expert
  final List<String>? relatedTips;
  final String? source;
  final String? videoUrl;
  final List<String>? images;

  const TipModel({
    this.id,
    this.title,
    this.content,
    this.summary,
    this.thumbnail,
    this.category,
    this.author,
    this.createdAt,
    this.updatedAt,
    this.viewCount,
    this.likeCount,
    this.bookmarkCount,
    this.isLiked,
    this.isBookmarked,
    this.tags,
    this.difficulty,
    this.estimatedTime,
    this.targetAudience,
    this.relatedTips,
    this.source,
    this.videoUrl,
    this.images,
  });

  factory TipModel.fromJson(Map<String, dynamic> json) =>
      _$TipModelFromJson(json);
  Map<String, dynamic> toJson() => _$TipModelToJson(this);

  TipModel copyWith({
    String? id,
    String? title,
    String? content,
    String? summary,
    String? thumbnail,
    String? category,
    String? author,
    String? createdAt,
    String? updatedAt,
    int? viewCount,
    int? likeCount,
    int? bookmarkCount,
    bool? isLiked,
    bool? isBookmarked,
    List<String>? tags,
    String? difficulty,
    String? estimatedTime,
    String? targetAudience,
    List<String>? relatedTips,
    String? source,
    String? videoUrl,
    List<String>? images,
  }) {
    return TipModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      summary: summary ?? this.summary,
      thumbnail: thumbnail ?? this.thumbnail,
      category: category ?? this.category,
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      viewCount: viewCount ?? this.viewCount,
      likeCount: likeCount ?? this.likeCount,
      bookmarkCount: bookmarkCount ?? this.bookmarkCount,
      isLiked: isLiked ?? this.isLiked,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      tags: tags ?? this.tags,
      difficulty: difficulty ?? this.difficulty,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      targetAudience: targetAudience ?? this.targetAudience,
      relatedTips: relatedTips ?? this.relatedTips,
      source: source ?? this.source,
      videoUrl: videoUrl ?? this.videoUrl,
      images: images ?? this.images,
    );
  }
}

@JsonSerializable()
class TipCategory {
  final String? id;
  final String? name;
  final String? description;
  final String? icon;
  final String? color;
  final int? tipCount;

  const TipCategory({
    this.id,
    this.name,
    this.description,
    this.icon,
    this.color,
    this.tipCount,
  });

  factory TipCategory.fromJson(Map<String, dynamic> json) =>
      _$TipCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$TipCategoryToJson(this);
}
