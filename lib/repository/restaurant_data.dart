// import 'dart:convert';

// import 'package:retaste_app/model/retaurant.dart';
// import 'package:flutter/services.dart';

// /// Kelas yang bertanggung jawab untuk mengambil data restoran dari file JSON lokal.
// class RestaurantData {
//   /// Metode untuk mengambil data restoran dari file JSON dan mengembalikan daftar restoran.
//   ///
//   /// Mengembalikan [List<Restaurant>] yang berisi daftar restoran yang diambil dari file JSON.
//   Future<List<Restaurant>> getRestaurantData() async {
//     // Mendapatkan data JSON dari file lokal
//     String jsonData =
//         await rootBundle.loadString('assets/local_restaurant.json');

//     // Mendekodekan data JSON menjadi Map<String, dynamic>
//     Map<String, dynamic> parsedData = jsonDecode(jsonData);

//     // Mendapatkan daftar restoran dari data yang di-decode
//     List<dynamic> restaurants = parsedData['restaurants'];

//     // Mengonversi daftar restoran menjadi List<Restaurant>
//     List<Restaurant> restaurantList = restaurants
//         .map((restaurant) => Restaurant.fromJson(restaurant))
//         .toList();

//     return restaurantList;
//   }
// }

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:retaste_app/model/restaurant_detail.dart';
import 'package:retaste_app/model/restaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantData {
  final SharedPreferences _sharedPreferences;

  final baseUrl = 'https://restaurant-api.dicoding.dev';

  final getRestaurant = '/list';
  final getRestaurantDetail = '/detail/';
  final searchRestaurant = '/search?q=';

  const RestaurantData({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  Future<void> saveRestaurantsToLocalStorage(
      List<Restaurant> restaurants) async {
    final String data =
        jsonEncode(restaurants.map((value) => value.toJson()).toList());

    _sharedPreferences.setString('cachedRestaurants', data);
  }

  Future<List<Restaurant>> getRestaurantFromLocalStorage() async {
    final String? data = _sharedPreferences.getString('cachedRestaurants');
    if (data != null) {
      final List<dynamic> decoded = jsonDecode(data);
      return decoded.map((value) => Restaurant.fromJson(value)).toList();
    }
    return [];
  }

  Future<List<Restaurant>> getRestaurantData() async {
    try {
      var dio = Dio();
      final response = await dio.get('$baseUrl$getRestaurant');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['restaurants'];
        return data.map((json) => Restaurant.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load restaurants');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<RestaurantDetail> fetchRestaurantDetail(String id) async {
    try {
      var dio = Dio();
      final response = await dio.get('$baseUrl$getRestaurantDetail$id');

      if (response.statusCode == 200) {
        return RestaurantDetail.fromJson(response.data['restaurant']);
      } else {
        throw Exception('Failed to load restaurant detail');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
