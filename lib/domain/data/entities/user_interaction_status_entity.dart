import 'package:sotaynamduoc/domain/data/entities/base_entity.dart';

class UserInteractionStatusEntity extends BaseEntity {
  bool? like;
  bool? bookmark;
  bool? view;
  bool? follow;
  bool? unfollow;

  UserInteractionStatusEntity.fromJson(Map<String, dynamic> json)
    : super.fromJson(json) {
    like = json['like'] ?? false;
    bookmark = json['bookmark'] ?? false;
    view = json['view'];

    if (json['herbal'] != null) {
      bookmark = json['bookmark'];
    }
    view = json['view'];
    follow = json['follow'];
    unfollow = json['unfollow'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['like'] = like;
    data['bookmark'] = bookmark;
    data['view'] = view;
    data['follow'] = follow;
    data['unfollow'] = unfollow;

    return data;
  }
}
