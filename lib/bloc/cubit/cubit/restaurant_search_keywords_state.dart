part of 'restaurant_search_keywords_cubit.dart';

class RestaurantSearchKeywordsState extends Equatable {
  const RestaurantSearchKeywordsState();

  @override
  List<Object> get props => [];
}

final class RestaurantSearchKeywordsInitial
    extends RestaurantSearchKeywordsState {}

final class RestaurantSearchKeywordsLoaded
    extends RestaurantSearchKeywordsState {
  final List<String> searchKeywords;

  const RestaurantSearchKeywordsLoaded(this.searchKeywords);

  @override
  List<Object> get props => [searchKeywords];
}

final class RestaurantSearchKeywordNavigatorActionState
    extends RestaurantSearchKeywordsState {
  final String keyword;

  const RestaurantSearchKeywordNavigatorActionState(this.keyword);

  @override
  List<Object> get props => [keyword];
}
