import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? prefs;

  static init() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  // Save Movies
  saveMovies(dynamic value) {
    return prefs!.setStringList("trendingMovies", value);
  }

  // Save top rated movies
  saveTopRatedMovies(dynamic value) {
    return prefs!.setStringList("topRatedMovies", value);
  }

  // Get Movies
  getMovies() {
    return prefs!.getString("trendingMovies") ?? '';
  }

  // Get top rated movies
  getTopRatedMovies() {
    return prefs!.getString("topRatedMovies") ?? '';
  }
}
