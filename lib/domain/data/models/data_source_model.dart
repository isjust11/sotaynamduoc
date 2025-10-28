// Nguồn tham khảo các kiểu dữ liệu (data sources reference)
enum DataSourceType {
  website,
  ebook,
  book,
  journal,
  researchPaper,
  interview,
  document,
  other;

  static DataSourceType fromString(String? value) {
    switch (value) {
      case 'website':
        return DataSourceType.website;
      case 'ebook':
        return DataSourceType.ebook;
      case 'book':
        return DataSourceType.book;
      case 'journal':
        return DataSourceType.journal;
      case 'research_paper':
        return DataSourceType.researchPaper;
      case 'interview':
        return DataSourceType.interview;
      case 'document':
        return DataSourceType.document;
      case 'other':
      default:
        return DataSourceType.other;
    }
  }

  String toJson() {
    switch (this) {
      case DataSourceType.website:
        return 'website';
      case DataSourceType.ebook:
        return 'ebook';
      case DataSourceType.book:
        return 'book';
      case DataSourceType.journal:
        return 'journal';
      case DataSourceType.researchPaper:
        return 'research_paper';
      case DataSourceType.interview:
        return 'interview';
      case DataSourceType.document:
        return 'document';
      case DataSourceType.other:
        return 'other';
    }
  }
}

class DataSourceModel {
  final int? id;
  final String? name;
  final String? title;
  final String? description;
  final DataSourceType type;
  final String? url;
  final String? author;
  final String? publisher;
  final String? publishDate;
  final String? isbn;
  final String? doi;
  final String? citation;
  final String? notes;
  final bool isActive;
  final String? createdAt;
  final String? updatedAt;

  DataSourceModel({
    this.id,
    this.name,
    this.title,
    this.description,
    required this.type,
    this.url,
    this.author,
    this.publisher,
    this.publishDate,
    this.isbn,
    this.doi,
    this.citation,
    this.notes,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  factory DataSourceModel.fromJson(Map<String, dynamic> json) {
    return DataSourceModel(
      id: json['id']?.toInt(),
      name: json['name']?.toString(),
      title: json['title']?.toString(),
      description: json['description']?.toString(),
      type: DataSourceType.fromString(json['type']?.toString()),
      url: json['url']?.toString(),
      author: json['author']?.toString(),
      publisher: json['publisher']?.toString(),
      publishDate: json['publishDate']?.toString(),
      isbn: json['isbn']?.toString(),
      doi: json['doi']?.toString(),
      citation: json['citation']?.toString(),
      notes: json['notes']?.toString(),
      isActive: json['isActive'] ?? true,
      createdAt: json['createdAt']?.toString(),
      updatedAt: json['updatedAt']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['title'] = title;
    data['description'] = description;
    data['type'] = type.toJson();
    data['url'] = url;
    data['author'] = author;
    data['publisher'] = publisher;
    data['publishDate'] = publishDate;
    data['isbn'] = isbn;
    data['doi'] = doi;
    data['citation'] = citation;
    data['notes'] = notes;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  DataSourceModel copyWith({
    int? id,
    String? name,
    String? title,
    String? description,
    DataSourceType? type,
    String? url,
    String? author,
    String? publisher,
    String? publishDate,
    String? isbn,
    String? doi,
    String? citation,
    String? notes,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
  }) {
    return DataSourceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      url: url ?? this.url,
      author: author ?? this.author,
      publisher: publisher ?? this.publisher,
      publishDate: publishDate ?? this.publishDate,
      isbn: isbn ?? this.isbn,
      doi: doi ?? this.doi,
      citation: citation ?? this.citation,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
