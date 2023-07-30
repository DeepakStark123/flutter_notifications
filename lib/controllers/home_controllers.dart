import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movies_app/services/notification_services.dart';
import 'package:movies_app/utils/strings.dart';
import 'package:tmdb_api/tmdb_api.dart';

class HomeController extends GetxController {
  List trendingMoviesList = [];
  List permanentTrendingMoviesList = [];
  List topRatedMoviesList = [];
  List permanentTopRatedMoviesList = [];
  bool loading = false;
  int tabIndex = 0;
  TextEditingController searchController = TextEditingController();
  NotificationServices notificationServices = NotificationServices();
  final box = GetStorage();

  loadingNotify(bool value) {
    loading = value;
    update();
  }

  changeTabIndex(int value) {
    tabIndex = value;
    getUpdatedData(value);
  }

  getUpdatedData(int index) {
    searchController.clear();
    if (index == 0) {
      topRatedMoviesList.clear();
      topRatedMoviesList.addAll(permanentTopRatedMoviesList);
    } else {
      trendingMoviesList.clear();
      trendingMoviesList.addAll(permanentTrendingMoviesList);
    }
    update();
  }

  getMovies() async {
    try {
      loadingNotify(true);
      final tmdbWithCustomLogs = TMDB(
        ApiKeys(apiKeyUrl, accessTokenUrl),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ),
      );
      trendingMoviesList.clear();
      topRatedMoviesList.clear();
      permanentTrendingMoviesList.clear();
      permanentTopRatedMoviesList.clear();
      Map mapPopularRes = await tmdbWithCustomLogs.v3.movies.getPopular();
      Map mapTopRatedRes = await tmdbWithCustomLogs.v3.movies.getTopRated();
      trendingMoviesList.addAll(mapPopularRes['results']);
      topRatedMoviesList.addAll(mapTopRatedRes['results']);
      permanentTrendingMoviesList.addAll(trendingMoviesList);
      permanentTopRatedMoviesList.addAll(topRatedMoviesList);
      box.write("trendingMovies", trendingMoviesList);
      box.write("topRatedMovies", topRatedMoviesList);
      update();
    } catch (e) {
      trendingMoviesList.clear();
      permanentTrendingMoviesList.clear();
      topRatedMoviesList.clear();
      permanentTopRatedMoviesList.clear();
      var movie = box.read('trendingMovies') ?? [];
      var topMovie = box.read('topRatedMovies') ?? [];
      trendingMoviesList.addAll(movie);
      topRatedMoviesList.addAll(topMovie);
      permanentTrendingMoviesList.addAll(trendingMoviesList);
      permanentTopRatedMoviesList.addAll(topRatedMoviesList);
      update();
      return Text("Exception Caught = $e");
    } finally {
      loadingNotify(false);
    }
  }

  List items = [];
  void serachTrendingMovies(String query) {
    debugPrint("query = $query");
    if (query == '' || query.toString() == "null") {
      trendingMoviesList.clear();
      trendingMoviesList.addAll(permanentTrendingMoviesList);
      update();
    } else {
      items.clear();
      items = permanentTrendingMoviesList
          .where((item) =>
              item['title'].toLowerCase().contains(query.toLowerCase()))
          .toList();
      trendingMoviesList.clear();
      trendingMoviesList.addAll(items);
      update();
    }
  }

  List itemsTopRated = [];
  void serachTopRatedMovies(String query) {
    debugPrint("query = $query");
    if (query == '' || query.toString() == "null") {
      topRatedMoviesList.clear();
      topRatedMoviesList.addAll(permanentTopRatedMoviesList);
      update();
    } else {
      itemsTopRated.clear();
      itemsTopRated = permanentTopRatedMoviesList
          .where((item) =>
              item['title'].toLowerCase().contains(query.toLowerCase()))
          .toList();
      topRatedMoviesList.clear();
      topRatedMoviesList.addAll(itemsTopRated);
      update();
    }
  }

  void init(BuildContext context) {
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      debugPrint('Device Token = $value');
    });
  }

  @override
  void onInit() {
    getMovies();
    super.onInit();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
