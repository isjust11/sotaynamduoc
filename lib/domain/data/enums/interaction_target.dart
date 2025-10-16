enum InteractionTarget {
  article('article'),
  herbal('herbal'),
  folkMedicine('folk_medicine'),
  author('author'),
  user('user'),
  comment('comment'),
  category('category'),
  none('none');

  const InteractionTarget(this.value);
  final String value;

  static InteractionTarget fromString(String value) {
    return InteractionTarget.values.firstWhere(
      (target) => target.value == value,
      orElse: () => InteractionTarget.none,
    );
  }
}
