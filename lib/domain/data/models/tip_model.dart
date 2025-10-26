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
  final List<TipModel>? relatedTips;
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

  factory TipModel.fromJson(Map<String, dynamic> json) {
    return TipModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      summary: json['summary'],
      thumbnail: json['thumbnail'],
      category: json['category'],
      author: json['author'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      viewCount: json['viewCount'],
      likeCount: json['likeCount'],
      bookmarkCount: json['bookmarkCount'],
      isLiked: json['isLiked'],
      isBookmarked: json['isBookmarked'],
      tags: json['tags'],
      difficulty: json['difficulty'],
      estimatedTime: json['estimatedTime'],
      targetAudience: json['targetAudience'],
      relatedTips: json['relatedTips'],
      source: json['source'],
      videoUrl: json['videoUrl'],
      images: json['images'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'summary': summary,
      'thumbnail': thumbnail,
      'category': category,
      'author': author,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'viewCount': viewCount,
      'likeCount': likeCount,
      'bookmarkCount': bookmarkCount,
      'isLiked': isLiked,
      'isBookmarked': isBookmarked,
      'tags': tags,
      'difficulty': difficulty,
      'estimatedTime': estimatedTime,
      'targetAudience': targetAudience,
      'relatedTips': relatedTips,
      'source': source,
      'videoUrl': videoUrl,
      'images': images,
    };
  }
}
