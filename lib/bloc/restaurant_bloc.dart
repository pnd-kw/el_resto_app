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
    on<FetchRestaurant>((event, emit) => addDataToState(emit));
    on<FetchRestaurantByQuery>(
        (event, emit) => getRestaurantByQuery(emit, event.query));
    on<RestaurantSearchNavigatorActionEvent>(
        (event, emit) => restaurantSearchNavigator(emit, event.id));
    on<RestaurantNavigatorActionEvent>(
        (event, emit) => restaurantNavigator(emit, event.id));
    on<FetchRestaurantDetail>(
        (event, emit) => getRestaurantDetail(emit, event.id));
  }

  Future<void> addDataToState(Emitter<RestaurantState> emit) async {
    try {
      emit(RestaurantLoading());

      final List<Restaurant> restaurantData =
          await _restaurantData.getRestaurantData();

      emit(RestaurantLoaded(restaurantData));
    } catch (e) {
      emit(const RestaurantError('Failed to load restaurants'));
    }
  }

  Future<void> getRestaurantByQuery(
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

  Future<void> getRestaurantDetail(
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
