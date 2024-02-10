import 'dart:async';

// import 'api.dart';
import 'package:dio/dio.dart';
import 'package:retaste_app/model/restaurant_detail.dart';
import 'package:retaste_app/model/restaurant.dart';

class RestaurantData {
  var dio = Dio();

  RestaurantData([Dio? dio]) {
    if (dio != null) {
      this.dio = dio;
    }
  }

  Future<List<Restaurant>> fetchRestaurantData(
      String baseUrl, String path) async {
    try {
      final response = await dio.get('$baseUrl$path');

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

  Future<List<Restaurant>> searchRestaurantData(
      String baseUrl, String path, String query) async {
    try {
      final response = await dio.get('$baseUrl$path$query');

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

  Future<RestaurantDetail> fetchRestaurantDetail(
      String baseUrl, String path, String id) async {
    try {
      final response = await dio.get('$baseUrl$path$id');
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
