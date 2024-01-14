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

class RestaurantByQueryLoading extends RestaurantState {}

class RestaurantByQueryLoaded extends RestaurantState {
  final List<Restaurant> restaurants;

  const RestaurantByQueryLoaded(this.restaurants);

  @override
  List<Object> get props => [restaurants];
}

class RestaurantByQueryEmpty extends RestaurantState {}

class RestaurantByQueryError extends RestaurantState {
  final String errorMessage;

  const RestaurantByQueryError(this.errorMessage);

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

abstract class RestaurantSearchActionState extends RestaurantState {}

class RestaurantSearchNavigatorActionState extends RestaurantSearchActionState {
  final String id;

  RestaurantSearchNavigatorActionState(this.id);

  @override
  List<Object> get props => [id];
}
