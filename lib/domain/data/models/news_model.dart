class NewsModel {
  final String id;
  final String title;
  final String content;
  final String description;
  final DateTime createdAt;
  final String? imageUrl;

  const NewsModel({
    required this.id,
    required this.title,
    required this.content,
    required this.description,
    required this.createdAt,
    this.imageUrl,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'imageUrl': imageUrl,
    };
  }

  String get formattedDate {
    return "${createdAt.day}/${createdAt.month}/${createdAt.year}";
  }

  String get timeString {
    return "${createdAt.hour.toString().padLeft(2, '0')}:${createdAt.minute.toString().padLeft(2, '0')}";
  }
} 