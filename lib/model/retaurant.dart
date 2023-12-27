// class Restaurant {
//   final String id;
//   final String name;
//   final String description;
//   final String image;
//   final String city;
//   final double rating;
//   final List<String> foods;
//   final List<String> drinks;

//   Restaurant({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.image,
//     required this.city,
//     required this.rating,
//     required this.foods,
//     required this.drinks,
//   });

//   factory Restaurant.fromJson(Map<String, dynamic> json) {
//     return Restaurant(
//       id: json['id'],
//       name: json['name'],
//       description: json['description'],
//       image: json['pictureId'],
//       city: json['city'],
//       rating: json['rating'].toDouble(),
//       foods:
//           List<String>.from(json['menus']['foods'].map((food) => food['name'])),
//       drinks: List<String>.from(
//           json['menus']['drinks'].map((drink) => drink['name'])),
//     );
//   }
// }

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
      );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "name": name,
  //       "description": description,
  //       "pictureId": pictureId,
  //       "city": city,
  //       "rating": rating,
  //     };
}
