import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:retaste_app/model/restaurant_detail.dart';
import 'package:retaste_app/model/restaurant.dart';
import 'package:retaste_app/repository/restaurant_data.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantData _restaurantData;

  RestaurantBloc(this._restaurantData) : super(RestaurantInitial()) {
    on<FetchRestaurant>((event, emit) => fetchRestaurant(emit));
    on<FetchRestaurantByQuery>(
        (event, emit) => fetchRestaurantByQuery(emit, event.query));
    on<RestaurantSearchNavigatorActionEvent>(
        (event, emit) => restaurantSearchNavigator(emit, event.id));
    on<RestaurantNavigatorActionEvent>(
        (event, emit) => restaurantNavigator(emit, event.id));
    on<FetchRestaurantDetail>(
        (event, emit) => fetchRestaurantDetail(emit, event.id));
  }

  Future<void> fetchRestaurant(Emitter<RestaurantState> emit) async {
    try {
      emit(RestaurantLoading());

      final List<Restaurant> restaurantData =
          await _restaurantData.fetchRestaurantData();

      emit(RestaurantLoaded(restaurantData));
    } catch (e) {
      emit(const RestaurantError('Failed to load restaurants'));
    }
  }

  Future<void> fetchRestaurantByQuery(
      Emitter<RestaurantState> emit, String query) async {
    try {
      emit(RestaurantByQueryLoading());

      final List<Restaurant> restaurantData =
          await _restaurantData.searchRestaurantData(query);

      if (restaurantData.isEmpty) {
        emit(RestaurantByQueryEmpty());
      } else {
        emit(RestaurantByQueryLoaded(restaurantData));
      }
    } catch (e) {
      emit(const RestaurantByQueryError('Failed to search restaurants'));
    }
  }

  Future<void> fetchRestaurantDetail(
      Emitter<RestaurantState> emit, String id) async {
    try {
      emit(RestaurantDetailLoading());

      final RestaurantDetail restaurantDetail =
          await _restaurantData.fetchRestaurantDetail(id);

      emit(RestaurantDetailLoaded(restaurantDetail: restaurantDetail));
    } catch (e) {
      emit(const RestaurantDetailError('Failed to load restaurant detail'));
    }
  }

  void restaurantNavigator(Emitter<RestaurantState> emit, String restaurantId) {
    emit(RestaurantNavigatorActionState(restaurantId));
  }

  void restaurantSearchNavigator(
      Emitter<RestaurantState> emit, String restaurantId) {
    emit(RestaurantSearchNavigatorActionState(restaurantId));
  }
}
