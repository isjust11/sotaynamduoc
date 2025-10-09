enum FeedbackStatus {
  pending('pending', 'Chờ xử lý'),
  inProgress('in_progress', 'Đang xử lý'),
  resolved('resolved', 'Đã giải quyết'),
  closed('closed', 'Đã đóng');

  const FeedbackStatus(this.value, this.displayName);
  final String value;
  final String displayName;

  static FeedbackStatus fromString(String value) {
    return FeedbackStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => FeedbackStatus.pending,
    );
  }
}
