part of 'restaurant_bloc.dart';

class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

class FetchRestaurant extends RestaurantEvent {}

class FetchRestaurantByQuery extends RestaurantEvent {
  final String query;

  const FetchRestaurantByQuery(this.query);

  @override
  List<Object> get props => [];
}

class FetchRestaurantDetail extends RestaurantEvent {
  final String id;

  const FetchRestaurantDetail({required this.id});

  @override
  List<Object> get props => [id];
}

class RestaurantNavigatorActionEvent extends RestaurantEvent {
  final String id;

  const RestaurantNavigatorActionEvent(this.id);

  @override
  List<Object> get props => [id];
}
