import 'package:dio/dio.dart';
import 'package:retaste_app/model/restaurant_detail.dart';
import 'package:retaste_app/model/restaurant.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class RestaurantData {
  final baseUrl = 'https://restaurant-api.dicoding.dev';

  final getRestaurant = '/list';
  final getRestaurantDetail = '/detail/';
  final searchRestaurant = '/search?q=';

  // RestaurantData({
  //   required SharedPreferences sharedPreferences,
  // }) : _sharedPreferences = sharedPreferences;

  // Future<void> saveRestaurantsToLocalStorage(
  //     List<Restaurant> restaurants) async {
  //   final String data =
  //       jsonEncode(restaurants.map((value) => value.toJson()).toList());

  //   _sharedPreferences.setString('cachedRestaurants', data);
  // }

  // Future<List<Restaurant>> getRestaurantFromLocalStorage() async {
  //   final String? data = _sharedPreferences.getString('cachedRestaurants');
  //   if (data != null) {
  //     final List<dynamic> decoded = jsonDecode(data);
  //     return decoded.map((value) => Restaurant.fromJson(value)).toList();
  //   }
  //   return [];
  // }

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

  Future<List<Restaurant>> searchRestaurantData(String query) async {
    try {
      var dio = Dio();
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
