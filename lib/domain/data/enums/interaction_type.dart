enum InteractionType {
  like('like'),
  dislike('dislike'),
  bookmark('bookmark'),
  share('share'),
  view('view'),
  comment('comment'),
  rate('rate'),
  follow('follow'),
  unfollow('unfollow');

  const InteractionType(this.value);
  final String value;

  static InteractionType fromString(String value) {
    return InteractionType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => InteractionType.view,
    );
  }
}
