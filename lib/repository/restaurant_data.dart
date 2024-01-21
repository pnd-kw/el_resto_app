import 'dart:async';

import 'api.dart';
import 'package:dio/dio.dart';
import 'package:retaste_app/model/restaurant_detail.dart';
import 'package:retaste_app/model/restaurant.dart';

class RestaurantData {
  var dio = Dio();

  Future<List<Restaurant>> fetchRestaurantData() async {
    try {
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

  Future<List<Restaurant>> searchRestaurantData(String query) async {
    try {
      final response = await dio.get('$baseUrl$searchRestaurant$query');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['restaurants'];
        return data.map((json) => Restaurant.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search restaurants');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<RestaurantDetail> fetchRestaurantDetail(String id) async {
    try {
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
