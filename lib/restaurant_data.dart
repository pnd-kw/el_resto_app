import 'dart:convert';

import 'package:flutter/services.dart';

class RestaurantData {
  Future<dynamic> getRestaurantData() async {
    String jsonData =
        await rootBundle.loadString('assets/local_restaurant.json');
    var parsedData = jsonDecode(jsonData);

    return parsedData;
  }
}
