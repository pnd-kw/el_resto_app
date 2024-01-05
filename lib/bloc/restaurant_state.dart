part of 'restaurant_bloc.dart';

class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final List<Restaurant> restaurants;

  const RestaurantLoaded(this.restaurants);

  @override
  List<Object> get props => [restaurants];
}

class RestaurantError extends RestaurantState {
  final String errorMessage;

  const RestaurantError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class RestaurantDetailInitial extends RestaurantState {}

class RestaurantDetailLoading extends RestaurantState {}

class RestaurantDetailLoaded extends RestaurantState {
  final RestaurantDetail restaurantDetail;

  const RestaurantDetailLoaded({required this.restaurantDetail});

  @override
  List<Object> get props => [restaurantDetail];
}

class RestaurantDetailError extends RestaurantState {
  final String errorMessage;

  const RestaurantDetailError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

abstract class RestaurantActionState extends RestaurantState {}

class RestaurantNavigatorActionState extends RestaurantActionState {
  final String id;

  RestaurantNavigatorActionState(this.id);

  @override
  List<Object> get props => [id];
}
