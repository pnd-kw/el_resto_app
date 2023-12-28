part of 'restaurant_bloc.dart';

class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

class FetchRestaurant extends RestaurantEvent {}

class FetchRestaurantDetail extends RestaurantEvent {
  final String id;

  const FetchRestaurantDetail({required this.id});

  @override
  List<Object> get props => [id];
}
