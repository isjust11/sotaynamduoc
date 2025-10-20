enum CategoryType {
  FolkMedicine('FolkMedicine'),
  Discovery('Discovery');

  const CategoryType(this.value);
  final String value;

  static CategoryType fromString(String value) {
    return CategoryType.values.firstWhere((type) => type.value == value);
  }
}
