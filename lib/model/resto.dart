import 'package:el_resto_app/model/menu_category.dart';

class Resto {
  final String id;
  final String name;
  final String image;
  final String description;
  final String serviceOptions;
  final String street;
  final String city;
  final String postalCode;
  final double rating;
  final String openHours;
  final List<List<MenuCategory>> menuCategories;

  const Resto({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.serviceOptions,
    required this.street,
    required this.city,
    required this.postalCode,
    required this.rating,
    required this.openHours,
    required this.menuCategories,
  });
}
