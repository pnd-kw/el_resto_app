import 'dart:convert';

import 'package:retaste_app/model/retaurant.dart';
import 'package:flutter/services.dart';

/// Kelas yang bertanggung jawab untuk mengambil data restoran dari file JSON lokal.
class RestaurantData {
  /// Metode untuk mengambil data restoran dari file JSON dan mengembalikan daftar restoran.
  ///
  /// Mengembalikan [List<Restaurant>] yang berisi daftar restoran yang diambil dari file JSON.
  Future<List<Restaurant>> getRestaurantData() async {
    // Mendapatkan data JSON dari file lokal
    String jsonData =
        await rootBundle.loadString('assets/local_restaurant.json');

    // Mendekodekan data JSON menjadi Map<String, dynamic>
    Map<String, dynamic> parsedData = jsonDecode(jsonData);

    // Mendapatkan daftar restoran dari data yang di-decode
    List<dynamic> restaurants = parsedData['restaurants'];

    // Mengonversi daftar restoran menjadi List<Restaurant>
    List<Restaurant> restaurantList = restaurants
        .map((restaurant) => Restaurant.fromJson(restaurant))
        .toList();

    return restaurantList;
  }
}
