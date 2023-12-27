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
