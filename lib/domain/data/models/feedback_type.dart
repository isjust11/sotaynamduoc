enum FeedbackType {
  bugReport('bug_report', 'Báo lỗi'),
  featureRequest('feature_request', 'Yêu cầu tính năng'),
  complaint('complaint', 'Khiếu nại'),
  suggestion('suggestion', 'Góp ý'),
  general('general', 'Chung');

  const FeedbackType(this.value, this.displayName);
  final String value;
  final String displayName;

  static FeedbackType fromString(String value) {
    return FeedbackType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => FeedbackType.general,
    );
  }
}
