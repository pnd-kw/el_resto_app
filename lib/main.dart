import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:retaste_app/bloc/cubit/cubit/favorite_restaurant_cubit.dart';
import 'package:retaste_app/presentation/home_page_screen.dart';
import 'package:retaste_app/repository/local/restaurant_database.dart';
import 'package:retaste_app/services/notification_service.dart';
import 'package:retaste_app/utils/style/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retaste_app/bloc/cubit/cubit/check_connection_cubit.dart';
import 'package:retaste_app/bloc/cubit/cubit/restaurant_search_keywords_cubit.dart';
import 'package:retaste_app/bloc/restaurant_bloc.dart';

import 'package:retaste_app/presentation/restaurant_detail_screen.dart';
// import 'package:retaste_app/presentation/restaurant_list_screen.dart';
import 'package:retaste_app/presentation/restaurant_search_screen.dart';

import 'package:retaste_app/repository/restaurant_data.dart';
import 'package:retaste_app/repository/restaurant_search_keywords_data.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  NotificationService().initNotification();

  await AndroidAlarmManager.initialize();

  final sharedPreferences = await SharedPreferences.getInstance();

  final CheckConnectionCubit checkConnectionCubit = CheckConnectionCubit();
  final RestaurantData restaurantData = RestaurantData();
  final RestaurantBloc restaurantBloc = RestaurantBloc(restaurantData);
  final RestaurantDatabase restaurantDatabase = RestaurantDatabase();
  final RestaurantSearchKeywordsData restaurantSearchKeywordsData =
      RestaurantSearchKeywordsData(prefs: sharedPreferences);
  final RestaurantSearchKeywordsCubit restaurantSearchKeywordsCubit =
      RestaurantSearchKeywordsCubit(restaurantSearchKeywordsData);
  final FavoriteRestaurantCubit favoriteRestaurantCubit =
      FavoriteRestaurantCubit(restaurantDatabase);

  runApp(RetasteApp(
    checkConnectionCubit: checkConnectionCubit,
    restaurantBloc: restaurantBloc,
    restaurantSearchKeywordsCubit: restaurantSearchKeywordsCubit,
    favoriteRestaurantCubit: favoriteRestaurantCubit,
  ));
}

class RetasteApp extends StatelessWidget {
  final CheckConnectionCubit checkConnectionCubit;
  final RestaurantBloc restaurantBloc;
  final RestaurantSearchKeywordsCubit restaurantSearchKeywordsCubit;
  final FavoriteRestaurantCubit favoriteRestaurantCubit;

  const RetasteApp(
      {super.key,
      required this.checkConnectionCubit,
      required this.restaurantBloc,
      required this.restaurantSearchKeywordsCubit,
      required this.favoriteRestaurantCubit});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => checkConnectionCubit),
        BlocProvider(
          create: (context) => restaurantBloc,
        ),
        BlocProvider(
          create: (context) => restaurantSearchKeywordsCubit,
        ),
        BlocProvider(
          create: (context) => favoriteRestaurantCubit,
        ),
      ],
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
          '/': (context) => const HomePageScreen(),
          // '/': (context) => const RestaurantListScreen(),
          '/restaurant-detail-screen': (context) =>
              const RestaurantDetailScreen(),
          '/restaurant-search-screen': (context) =>
              const RestaurantSearchScreen(),
        },
      ),
    );
  }
}
