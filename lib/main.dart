import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retaste_app/bloc/restaurant_bloc.dart';
import 'package:retaste_app/presentation/restaurant_detail_screen.dart';
import 'package:retaste_app/presentation/restaurant_list_screen.dart';
// import 'package:retaste_app/presentation/restaurant_search_result_screen.dart';
import 'package:retaste_app/presentation/restaurant_search_screen.dart';
import 'package:retaste_app/repository/restaurant_data.dart';
// import 'package:retaste_app/utils/search_result_arguments.dart';
import 'package:retaste_app/utils/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  final RestaurantData restaurantData =
      RestaurantData(sharedPreferences: sharedPreferences);
  final RestaurantBloc restaurantBloc = RestaurantBloc(restaurantData);

  runApp(RetasteApp(restaurantBloc: restaurantBloc));
}

class RetasteApp extends StatelessWidget {
  final RestaurantBloc restaurantBloc;

  const RetasteApp({super.key, required this.restaurantBloc});

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
          '/': (context) => const RestaurantListScreen(),
          '/restaurant-detail-screen': (context) =>
              const RestaurantDetailScreen(),
          '/restaurant-search-screen': (context) =>
              const RestaurantSearchScreen(),

          // '/restaurant-search-result-screen': (context) =>
          //     const SearchResultScreen(textFieldKey: textFieldKey),
        },
      ),
    );
  }
}
