import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retaste_app/model/restaurant_detail.dart';
import 'package:retaste_app/repository/restaurant_data.dart';

import 'fetch_restaurant_data_test.mocks.dart';

class MockDio extends Mock implements Dio {}

@GenerateMocks([MockDio])
void main() {
  test('Fetch Restaurant Data By Id - JSON Parsing Test', () async {
    // Arrange
    const id = '1';
    const baseUrl = 'https://example.com';
    const path = '/detail/';
    const url = '$baseUrl$path$id';
    final dio = MockMockDio();
    final restaurantData = RestaurantData(dio);
    final jsonResponse = {
      "restaurant": {
        "id": "1",
        "name": "First Restaurant",
        "description": "Lorem ipsum...",
        "city": "Medan",
        "address": "Jln. Pandeglang no 19",
        "pictureId": "14",
        "categories": [
          {"name": "Italia"},
          {"name": "Modern"}
        ],
        "menus": {
          "foods": [
            {"name": "Paket rosemary"}
          ],
          "drinks": [
            {"name": "Es krim"}
          ]
        },
        "rating": 4.2,
        "customerReviews": [
          {
            "name": "Ahmad",
            "review": "Tidak rekomendasi untuk pelajar!",
            "date": "13 November 2019"
          }
        ]
      }
    };

    when(dio.get(any, queryParameters: anyNamed('queryParameters'))).thenAnswer(
        (_) async => Response(
            data: jsonResponse,
            statusCode: 200,
            requestOptions: RequestOptions(path: '')));

    // Act
    final result =
        await restaurantData.fetchRestaurantDetail(baseUrl, path, id);

    verify(dio.get(url, queryParameters: null)).called(1);

    // Assert
    expect(
        result,
        equals(const RestaurantDetail(
            id: "1",
            name: "First Restaurant",
            description: "Lorem ipsum...",
            city: "Medan",
            address: "Jln. Pandeglang no 19",
            pictureId: "14",
            categories: [Category(name: "Italia"), Category(name: "Modern")],
            menus: Menus(
                foods: [Category(name: "Paket rosemary")],
                drinks: [Category(name: "Es krim")]),
            rating: 4.2,
            customerReviews: [
              CustomerReview(
                  name: "Ahmad",
                  review: "Tidak rekomendasi untuk pelajar!",
                  date: "13 November 2019")
            ])));
  });
}
