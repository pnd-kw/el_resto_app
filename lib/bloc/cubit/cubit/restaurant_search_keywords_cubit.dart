import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:retaste_app/repository/restaurant_search_keywords_data.dart';

part 'restaurant_search_keywords_state.dart';

class RestaurantSearchKeywordsCubit
    extends Cubit<RestaurantSearchKeywordsState> {
  final RestaurantSearchKeywordsData _restaurantSearchKeywordsData;

  RestaurantSearchKeywordsCubit(this._restaurantSearchKeywordsData)
      : super(RestaurantSearchKeywordsInitial());

  void saveSearchKeyword(String keyword) {
    _restaurantSearchKeywordsData.addSearchKeyword(keyword);
    _restaurantSearchKeywordsData.saveSearchKeywords();
  }

  void loadSearchKeywords() {
    _restaurantSearchKeywordsData.loadSearchKeywords();

    emit(RestaurantSearchKeywordsLoaded(
        _restaurantSearchKeywordsData.searchKeywords));
  }

  void navigatorAction(String keyword) {
    emit(RestaurantSearchKeywordNavigatorActionState(keyword));
  }
}
