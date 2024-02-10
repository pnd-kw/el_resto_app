// class RestaurantDetail {
//   String id;
//   String name;
//   String description;
//   String city;
//   String address;
//   String pictureId;
//   List<Category> categories;
//   Menus menus;
//   double rating;
//   List<CustomerReview> customerReviews;

//   RestaurantDetail({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.city,
//     required this.address,
//     required this.pictureId,
//     required this.categories,
//     required this.menus,
//     required this.rating,
//     required this.customerReviews,
//   });

//   factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
//       RestaurantDetail(
//         id: json["id"],
//         name: json["name"],
//         description: json["description"],
//         city: json["city"],
//         address: json["address"],
//         pictureId: json["pictureId"],
//         categories: List<Category>.from(
//             json["categories"].map((category) => Category.fromJson(category))),
//         menus: Menus.fromJson(json["menus"]),
//         rating: json["rating"]?.toDouble(),
//         customerReviews: List<CustomerReview>.from(json["customerReviews"]
//             .map((review) => CustomerReview.fromJson(review))),
//       );
// }

// class Category {
//   String name;

//   Category({
//     required this.name,
//   });

//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//         name: json["name"],
//       );
// }

// class CustomerReview {
//   String name;
//   String review;
//   String date;

//   CustomerReview({
//     required this.name,
//     required this.review,
//     required this.date,
//   });

//   factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
//         name: json["name"],
//         review: json["review"],
//         date: json["date"],
//       );
// }

// class Menus {
//   List<Category> foods;
//   List<Category> drinks;

//   Menus({
//     required this.foods,
//     required this.drinks,
//   });

//   factory Menus.fromJson(Map<String, dynamic> json) => Menus(
//         foods: List<Category>.from(
//             json["foods"].map((food) => Category.fromJson(food))),
//         drinks: List<Category>.from(
//             json["drinks"].map((drink) => Category.fromJson(drink))),
//       );
// }

import 'package:equatable/equatable.dart';

class RestaurantDetail extends Equatable {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final double rating;
  final List<Category> categories;
  final Menus menus;
  final List<CustomerReview> customerReviews;

  const RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.rating,
    required this.categories,
    required this.menus,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<Category>.from(
            json["categories"].map((category) => Category.fromJson(category))),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"]?.toDouble(),
        customerReviews: List<CustomerReview>.from(json["customerReviews"]
            .map((review) => CustomerReview.fromJson(review))),
      );

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        city,
        address,
        pictureId,
        rating,
        categories,
        menus,
        customerReviews,
      ];
}

class Category extends Equatable {
  final String name;

  const Category({
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );

  @override
  List<Object?> get props => [name];
}

class CustomerReview extends Equatable {
  final String name;
  final String review;
  final String date;

  const CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );

  @override
  List<Object?> get props => [name, review, date];
}

class Menus extends Equatable {
  final List<Category> foods;
  final List<Category> drinks;

  const Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Category>.from(
            json["foods"].map((food) => Category.fromJson(food))),
        drinks: List<Category>.from(
            json["drinks"].map((drink) => Category.fromJson(drink))),
      );

  @override
  List<Object?> get props => [foods, drinks];
}
