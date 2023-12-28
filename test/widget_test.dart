// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:retaste_app/bloc/restaurant_bloc.dart';

import 'package:retaste_app/main.dart';
import 'package:retaste_app/repository/restaurant_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final RestaurantData restaurantData =
      RestaurantData(sharedPreferences: sharedPreferences);
  final RestaurantBloc restaurantBloc = RestaurantBloc(restaurantData);
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(RetasteApp(restaurantBloc: restaurantBloc));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
