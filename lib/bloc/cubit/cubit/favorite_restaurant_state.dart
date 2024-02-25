part of 'favorite_restaurant_cubit.dart';

class FavoriteRestaurantState extends Equatable {
  const FavoriteRestaurantState();

  @override
  List<Object> get props => [];
}

final class FavoriteRestaurantInitial extends FavoriteRestaurantState {}

// final class FavoriteRestaurantLoading extends FavoriteRestaurantState {}

final class FavoriteRestaurantEmpty extends FavoriteRestaurantState {}

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

abstract class FavoriteRestaurantActionState extends FavoriteRestaurantState {}

final class ToggleFavoriteActionState extends FavoriteRestaurantActionState {
  final String id;
  final bool isFavorite;

  ToggleFavoriteActionState(this.id, this.isFavorite);

  @override
  List<Object> get props => [id, isFavorite];
}

final class NavigatorActionState extends FavoriteRestaurantActionState {
  final String id;

  NavigatorActionState(this.id);

  @override
  List<Object> get props => [id];
}
