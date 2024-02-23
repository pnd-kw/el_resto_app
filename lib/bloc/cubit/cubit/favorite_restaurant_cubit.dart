import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:retaste_app/model/restaurant.dart';
import 'package:retaste_app/repository/local/restaurant_database.dart';

part 'favorite_restaurant_state.dart';

class FavoriteRestaurantCubit extends Cubit<FavoriteRestaurantState> {
  final RestaurantDatabase _restaurantDatabase;

  FavoriteRestaurantCubit(this._restaurantDatabase)
      : super(FavoriteRestaurantInitial());

  Future<void> loadFavoriteRestaurants() async {
    try {
      final List<Restaurant> favoriteRestaurants =
          await _restaurantDatabase.getFavoriteRestaurants();
      emit(FavoriteRestaurantLoaded(favoriteRestaurants));
    } catch (e) {
      emit(const FavoriteRestaurantError(
          'Failed to load favorite restaurants.'));
    }
  }

  Future<void> toggleFavoriteStatus(String id, bool isFavorite) async {
    try {
      await _restaurantDatabase.toggleFavoriteStatus(id, isFavorite);
      emit(FavoriteRestaurantActionState(id, isFavorite));
    } catch (e) {
      emit(const FavoriteRestaurantError(
          'Failed to add restaurant as favorite.'));
    }
  }
}
