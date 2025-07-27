class NewsModel {
  final String id;
  final String? title;
  final String? content;
  final String? summary;
  final DateTime? createdAt;
  final String? thumbnail;

  const NewsModel({
    required this.id,
    required this.title,
    required this.content,
    required this.summary,
    required this.createdAt,
    this.thumbnail,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      summary: json['summary'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      thumbnail: json['thumbnail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'summary': summary,
      'createdAt': createdAt?.toIso8601String(),
      'thumbnail': thumbnail,
    };
  }

  String get formattedDate {
    return "${createdAt?.day}/${createdAt?.month}/${createdAt?.year}";
  }

  String get timeString {
    return "${createdAt?.hour.toString().padLeft(2, '0')}:${createdAt?.minute.toString().padLeft(2, '0')}";
  }
}
