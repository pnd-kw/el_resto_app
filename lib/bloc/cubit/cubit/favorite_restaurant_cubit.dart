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

      print('Favorite Restaurants: $favoriteRestaurants');

      if (favoriteRestaurants.isNotEmpty) {
        emit(FavoriteRestaurantLoaded(favoriteRestaurants));
      } else {
        emit(FavoriteRestaurantEmpty());
      }
    } catch (e) {
      emit(const FavoriteRestaurantError(
          'Failed to load favorite restaurants.'));
    }
  }

  Future<void> toggleFavoriteStatus(String id, String name, String description,
      String pictureId, String city, double rating, bool isFavorite) async {
    try {
      await _restaurantDatabase.toggleFavoriteStatus(
          id, name, description, pictureId, city, rating, isFavorite);
      emit(ToggleFavoriteActionState(id, isFavorite));
      // refreshFavoriteRestaurants();
    } catch (e) {
      emit(const FavoriteRestaurantError(
          'Failed to add restaurant as favorite.'));
    }
  }

  void navigateToRestaurantDetail(String restaurantId) {
    emit(NavigatorActionState(restaurantId));
  }

  // void refreshFavoriteRestaurants() {
  //   loadFavoriteRestaurants();
  // }
}
