import 'package:shared_preferences/shared_preferences.dart';

class RestaurantSearchKeywordsData {
  final SharedPreferences _prefs;
  List<String> searchKeywords = [];

  RestaurantSearchKeywordsData({
    required SharedPreferences prefs,
  }) : _prefs = prefs {
    searchKeywords = _prefs.getStringList('searchKeywords') ?? [];
  }

  List<String> addSearchKeyword(String keyword) {
    searchKeywords.remove(keyword);
    searchKeywords.insert(0, keyword);

    if (searchKeywords.length > 6) {
      searchKeywords = searchKeywords.sublist(0, 6);
    }

    saveSearchKeywords();

    return searchKeywords;
  }

  void saveSearchKeywords() {
    _prefs.setStringList('searchKeywords', searchKeywords);
  }

  List<String> loadSearchKeywords() {
    final List<String>? loadedSearchKeywords =
        _prefs.getStringList('searchKeywords');

    return loadedSearchKeywords ?? [];
  }
}
