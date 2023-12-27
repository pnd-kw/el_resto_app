import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:retaste_app/model/retaurant.dart';
import 'package:retaste_app/repository/restaurant_data.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantData _restaurantData;

  RestaurantBloc(this._restaurantData) : super(RestaurantInitial()) {
    on<FetchRestaurant>((event, emit) => addDataToState(emit));
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
}
