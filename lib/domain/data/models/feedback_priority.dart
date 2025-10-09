enum FeedbackPriority {
  low('low', 'Thấp'),
  medium('medium', 'Trung bình'),
  high('high', 'Cao'),
  urgent('urgent', 'Khẩn cấp');

  const FeedbackPriority(this.value, this.displayName);
  final String value;
  final String displayName;

  static FeedbackPriority fromString(String value) {
    return FeedbackPriority.values.firstWhere(
      (priority) => priority.value == value,
      orElse: () => FeedbackPriority.medium,
    );
  }
}
