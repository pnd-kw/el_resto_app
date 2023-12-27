import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retaste_app/bloc/restaurant_bloc.dart';
import 'package:retaste_app/presentation/restaurant_detail.dart';
import 'package:retaste_app/presentation/restaurant_list.dart';
import 'package:retaste_app/repository/restaurant_data.dart';
import 'package:retaste_app/utils/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  final RestaurantData restaurantData = RestaurantData();
  final RestaurantBloc restaurantBloc = RestaurantBloc(restaurantData);
  runApp(MyApp(restaurantBloc: restaurantBloc));
}

class MyApp extends StatelessWidget {
  final RestaurantBloc restaurantBloc;

  const MyApp({super.key, required this.restaurantBloc});

  // This widget is the root of this application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => restaurantBloc,
      child: MaterialApp(
        title: 'Retaste',
        theme: theme,
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const RestaurantList(),
          // '/restaurant-detail': (context) => const RestaurantDetail(),
        },
      ),
    );
  }
}
