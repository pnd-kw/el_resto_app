import 'package:el_resto_app/model/menu.dart';

class MenuCategory {
  final String id;
  final String restoId;
  final String title;
  String? subtitle;
  final List<Menu> menuItems;

  MenuCategory({
    required this.id,
    required this.restoId,
    required this.title,
    this.subtitle,
    required this.menuItems,
  });
}
