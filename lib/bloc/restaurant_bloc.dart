import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:retaste_app/model/restaurant_detail.dart';
import 'package:retaste_app/model/restaurant.dart';
import 'package:retaste_app/repository/restaurant_data.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantData _restaurantData;
  // List<String> searchKeywords = [];

  RestaurantBloc(this._restaurantData) : super(RestaurantInitial()) {
    on<FetchRestaurant>((event, emit) => addDataToState(emit));
    on<FetchRestaurantByQuery>(
        (event, emit) => getRestaurantByQuery(emit, event.query));
    // on<AddSearchKeywordEvent>((event, emit) => searchHistory(event.keyword));
    on<RestaurantSearchNavigatorActionEvent>(
        (event, emit) => restaurantSearchNavigator(emit, event.id));
    on<RestaurantNavigatorActionEvent>(
        (event, emit) => restaurantNavigator(emit, event.id));
    on<FetchRestaurantDetail>(
        (event, emit) => getRestaurantDetail(emit, event.id));
  }

  // List<String> searchHistory(String keyword) {
  //   searchKeywords.remove(keyword);

  //   searchKeywords.insert(0, keyword);

  //   if (searchKeywords.length > 9) {
  //     searchKeywords = searchKeywords.sublist(0, 9);
  //   }

  //   print(searchKeywords);
  //   return searchKeywords;
  // }

  // Future<void> saveSearchKeywords() async {
  //   _sharedPreferences.setStringList('searchKeywords', searchKeywords);
  // }

  // Future<void> loadSearchKeywords() async {
  //   _sharedPreferences.getStringList('searchKeywords') ?? [];
  // }

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
