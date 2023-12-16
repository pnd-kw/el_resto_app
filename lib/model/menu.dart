class Menu {
  final String id;
  final String menuCategoryId;
  final String name;
  String? description;
  final double price;

  Menu({
    required this.id,
    required this.menuCategoryId,
    required this.name,
    this.description,
    required this.price,
  });
}
