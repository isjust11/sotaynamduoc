import 'feedback_type.dart';
import 'feedback_priority.dart';
import 'feedback_status.dart';

class FeedbackModel {
  final String? id;
  final String title;
  final String content;
  final FeedbackType type;
  final FeedbackStatus status;
  final FeedbackPriority priority;
  final String? email;
  final String? phone;
  final String? name;
  final String? deviceInfo;
  final String? appVersion;
  final String? osVersion;
  final List<String>? attachments;
  final String? adminResponse;
  final String? adminNotes;
  final bool isPublic;
  final bool isAnonymous;
  final int? userId;
  final int? assignedToId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? resolvedAt;

  const FeedbackModel({
    this.id,
    required this.title,
    required this.content,
    this.type = FeedbackType.general,
    this.status = FeedbackStatus.pending,
    this.priority = FeedbackPriority.medium,
    this.email,
    this.phone,
    this.name,
    this.deviceInfo,
    this.appVersion,
    this.osVersion,
    this.attachments,
    this.adminResponse,
    this.adminNotes,
    this.isPublic = false,
    this.isAnonymous = false,
    this.userId,
    this.assignedToId,
    this.createdAt,
    this.updatedAt,
    this.resolvedAt,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'],
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      type: FeedbackType.fromString(json['type']),
      status: FeedbackStatus.fromString(json['status']),
      priority: FeedbackPriority.fromString(json['priority']),
      email: json['email'],
      phone: json['phone'],
      name: json['name'],
      deviceInfo: json['deviceInfo'],
      appVersion: json['appVersion'],
      osVersion: json['osVersion'],
      attachments: json['attachments'] != null && json['attachments'] is List
          ? List<String>.from(json['attachments'] as List)
          : null,
      adminResponse: json['adminResponse'],
      adminNotes: json['adminNotes'],
      isPublic: json['isPublic'] ?? false,
      isAnonymous: json['isAnonymous'] ?? false,
      assignedToId: json['assignedToId'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      resolvedAt: json['resolvedAt'] != null
          ? DateTime.parse(json['resolvedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'type': type.value,
      'priority': priority.value,
      'email': email,
      'phone': phone,
      'name': name,
      'deviceInfo': deviceInfo,
      'appVersion': appVersion,
      'osVersion': osVersion,
      'attachments': attachments,
      'isPublic': isPublic,
      'isAnonymous': isAnonymous,
      'userId': userId,
    };
  }

  FeedbackModel copyWith({
    int? id,
    String? title,
    String? content,
    FeedbackType? type,
    FeedbackStatus? status,
    FeedbackPriority? priority,
    String? email,
    String? phone,
    String? name,
    String? deviceInfo,
    String? appVersion,
    String? osVersion,
    List<String>? attachments,
    String? adminResponse,
    String? adminNotes,
    bool? isPublic,
    bool? isAnonymous,
    int? userId,
    int? assignedToId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? resolvedAt,
  }) {
    return FeedbackModel(
      id: id as String?,
      title: title ?? this.title,
      content: content ?? this.content,
      type: type ?? this.type,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      deviceInfo: deviceInfo ?? this.deviceInfo,
      appVersion: appVersion ?? this.appVersion,
      osVersion: osVersion ?? this.osVersion,
      attachments: attachments ?? this.attachments,
      adminResponse: adminResponse ?? this.adminResponse,
      adminNotes: adminNotes ?? this.adminNotes,
      isPublic: isPublic ?? this.isPublic,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      userId: userId ?? this.userId,
      assignedToId: assignedToId ?? this.assignedToId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
    );
  }
}
