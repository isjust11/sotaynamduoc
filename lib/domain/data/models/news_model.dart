import 'package:sotaynamduoc/domain/data/models/category_model.dart';

class NewsModel {
  final String? id;
  final String? title;
  final String? content;
  final String? summary;
  final DateTime? createdAt;
  final String? thumbnail;
  final int? view;
  final int? like;
  final String? categoryId;
  final CategoryModel? status;
  final String? statusId;
  const NewsModel({
    this.id,
    required this.title,
    required this.content,
    required this.summary,
    required this.createdAt,
    this.thumbnail,
    this.view,
    this.like,
    this.categoryId,
    this.status,
    this.statusId,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      summary: json['summary'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      thumbnail: json['thumbnail'] ?? '',
      view: json['view'] ?? 0,
      like: json['like'] ?? 0,
      categoryId: json['categoryId']?.toString() ?? '',
      status: json['status'] is Map<String, dynamic>
          ? CategoryModel.fromJson(json['status'] as Map<String, dynamic>)
          : null,
      statusId: json['statusId']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id?.toString(),
      'title': title,
      'content': content,
      'summary': summary,
      'createdAt': createdAt?.toIso8601String(),
      'thumbnail': thumbnail,
      'view': view,
      'like': like,
      'categoryId': categoryId?.toString(),
      // Only include statusId in JSON; nested objects are often omitted in writes
      'statusId': statusId?.toString() ?? '',
      // Keep 'status' out to avoid serializing complex object without a toJson
    };
  }

  String get formattedDate {
    return "${createdAt?.day}/${createdAt?.month}/${createdAt?.year}";
  }

  String get timeString {
    return "${createdAt?.hour.toString().padLeft(2, '0')}:${createdAt?.minute.toString().padLeft(2, '0')}";
  }
}
