import 'package:sotaynamduoc/domain/data/entities/category_entity.dart';

class FolkMedicineEntity {
/*
{
  "id": "MQ==",
  "title": "Bài thuốc chữa rôm sảy",
  "slug": "bai-thuoc-chua-rom-say",
  "summary": "test ",
  "content": "<p>test 123</p>",
  "ingredients": "kỳ từ , ich nhân",
  "preparation": "nấu",
  "usage": "test",
  "notes": "",
  "thumbnail": "/uploads/1/1753955869559-mach_me_meo_dan_gian_dieu_tri_rom_say_cho_con_hieu_qua_1_b4b5b59ec9.jpg",
  "viewCount": 0,
  "likeCount": 0,
  "authorId": "aOG6o2kgdGjGsOG7o25nIGzDo24gw7RuZw==",
  "category": {
    "id": "NDBlMDBiY2ItMGNlOC00MmQyLWI4ZjMtYjIwMTM0MmU1Zjk5",
    "name": "Bệnh thường gặp ở trẻ em",
    "description": "Tổng hợp các bài thuốc liên quan tới các bệnh thường gặp ở trẻ em",
    "icon": "",
    "iconType": "lucide",
    "iconSize": null,
    "className": null,
    "isActive": true,
    "code": "BENH_TRE_EM",
    "allowEdit": true,
    "categoryTypeId": "NGRkNzAxY2EtNjhmNi00Nzk4LWFmMjItNTE5YjEyYzg5MGIx",
    "sortOrder": 0,
    "isDefault": false,
    "createBy": "1",
    "createdAt": "2025-07-31T08:19:56.000Z",
    "updatedAt": "2025-07-31T08:20:04.000Z"
  },
  "categoryId": "NDBlMDBiY2ItMGNlOC00MmQyLWI4ZjMtYjIwMTM0MmU1Zjk5",
  "isActive": true,
  "createdAt": "2025-07-31T09:58:03.000Z",
  "updatedAt": "2025-07-31T09:58:03.000Z"
} 
*/

  String? id;
  String? title;
  String? slug;
  String? summary;
  String? content;
  String? ingredients;
  String? preparation;
  String? usage;
  String? notes;
  String? thumbnail;
  int? viewCount;
  int? likeCount;
  String? authorId;
  CategoryEntity? category;
  String? categoryId;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  FolkMedicineEntity({
    this.id,
    this.title,
    this.slug,
    this.summary,
    this.content,
    this.ingredients,
    this.preparation,
    this.usage,
    this.notes,
    this.thumbnail,
    this.viewCount,
    this.likeCount,
    this.authorId,
    this.category,
    this.categoryId,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });
  FolkMedicineEntity.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    title = json['title']?.toString();
    slug = json['slug']?.toString();
    summary = json['summary']?.toString();
    content = json['content']?.toString();
    ingredients = json['ingredients']?.toString();
    preparation = json['preparation']?.toString();
    usage = json['usage']?.toString();
    notes = json['notes']?.toString();
    thumbnail = json['thumbnail']?.toString();
    viewCount = json['viewCount']?.toInt();
    likeCount = json['likeCount']?.toInt();
    authorId = json['authorId']?.toString();
    category = (json['category'] != null) ? CategoryEntity.fromJson(json['category']) : null;
    categoryId = json['categoryId']?.toString();
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
    data['ingredients'] = ingredients;
    data['preparation'] = preparation;
    data['usage'] = usage;
    data['notes'] = notes;
    data['thumbnail'] = thumbnail;
    data['viewCount'] = viewCount;
    data['likeCount'] = likeCount;
    data['authorId'] = authorId;
    if (category != null) {
      data['category'] = category?.toJson();
    }
    data['categoryId'] = categoryId;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
