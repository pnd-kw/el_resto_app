class MenuCategory {
  final String menuCategoryId;
  final String title;
  String? subtitle;

  MenuCategory({
    required this.menuCategoryId,
    required this.title,
    this.subtitle,
  });
}
