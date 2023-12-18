class Menu {
  final String menuId;
  final String restoId;
  final String menuCategoryId;
  final String name;
  String? description;
  final double price;

  Menu({
    required this.menuId,
    required this.restoId,
    required this.menuCategoryId,
    required this.name,
    this.description,
    required this.price,
  });
}
