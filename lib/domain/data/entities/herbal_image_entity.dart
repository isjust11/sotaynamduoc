
class HerbalImageEntity {
  String? id;
  String? url;
  String? alt;
  String? description;
  String? type;
  int? sortOrder;
  bool? isActive;
  String? herbalId;
  String? createdAt;
  String? updatedAt;

  HerbalImageEntity({
    this.id,
    this.url,
    this.alt,
    this.description,
    this.type,
    this.sortOrder,
    this.isActive,
    this.herbalId,
    this.createdAt,
    this.updatedAt,
  });
  HerbalImageEntity.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    url = json['url']?.toString();
    alt = json['alt']?.toString();
    description = json['description']?.toString();
    type = json['type']?.toString();
    sortOrder = json['sortOrder']?.toInt();
    isActive = json['isActive'];
    herbalId = json['herbalId']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['alt'] = alt;
    data['description'] = description;
    data['type'] = type;
    data['sortOrder'] = sortOrder;
    data['isActive'] = isActive;
    data['herbalId'] = herbalId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}