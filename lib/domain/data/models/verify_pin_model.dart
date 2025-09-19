import 'package:sotaynamduoc/domain/data/entities/base_entity.dart';

class VerifyPINModel extends BaseEntity {
  String? code;
  String? message;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    return data;
  }

  VerifyPINModel.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    code = json['code'];
    message = json['message'];
  }
}
