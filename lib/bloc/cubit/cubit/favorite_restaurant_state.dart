part of 'favorite_restaurant_cubit.dart';

class FavoriteRestaurantState extends Equatable {
  const FavoriteRestaurantState();

  @override
  List<Object> get props => [];
}

final class FavoriteRestaurantInitial extends FavoriteRestaurantState {}

final class FavoriteRestaurantLoaded extends FavoriteRestaurantState {
  final List<Restaurant> restaurants;

  const FavoriteRestaurantLoaded(this.restaurants);

  @override
  List<Object> get props => [restaurants];
}

final class FavoriteRestaurantError extends FavoriteRestaurantState {
  final String errorMessage;

  const FavoriteRestaurantError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

final class FavoriteRestaurantActionState extends FavoriteRestaurantState {
  final String id;
  final bool isFavorite;

  const FavoriteRestaurantActionState(this.id, this.isFavorite);

  @override
  List<Object> get props => [id, isFavorite];
}
