import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controllers/home_controllers.dart';
import 'package:movies_app/views/tranding_movies.dart';
import 'top_rated_movies.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var homeController = Get.put(HomeController())..init(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              // send notification from one device to another
              homeController.notificationServices
                  .getDeviceToken()
                  .then((value) async {
                var data = {
                  // 'to': value.toString(),
                  'to':
                      'dCzbK9gNRHSAmvVzRvW19z:APA91bG0U2Xj0A6UjUknz7vMGmIYyHapwO_y-wNaDMDhn9lgotT3bxKioQok1NKwLo47pk9DV0ZDhgtGWzSLVz7ZaARrj26UwM_CtxZ8oGLuIyL5ttL_pDyw3rzKwRIm1CYBPtvKXfLt',
                  'notification': {
                    'title': 'Deepak',
                    'body': 'Subscribe to my channel',
                    // "sound": "jetsons_doorbell.mp3"
                  },
                  'data': {'type': 'msj', 'id': 'Deepak'},
                  'android': {
                    'notification': {
                      'notification_count': 23,
                    },
                  },
                };

                await http.post(
                    Uri.parse('https://fcm.googleapis.com/fcm/send'),
                    body: jsonEncode(data),
                    headers: {
                      'Content-Type': 'application/json; charset=UTF-8',
                      'Authorization':
                          'key=AAAA1QxR80k:APA91bGbEWi5nx2vNKGVSl6e6urK_9aqdvCSz_Bq4j99mCpqsdOkd7TNlia7lbt9b8RZB4GG0rpZR5et_tl49iZTOuL_P3i05beu70JNXvcoC33jX7vCNASHuKTRcs_jxTvLpp__kgj7'
                    }).then((value) {
                  debugPrint("Response = ${value.body}");
                }).onError((error, stackTrace) {
                  debugPrint("Errror = $error");
                });
              });
            },
            label: const Text("Send Message")),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purple.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: TextField(
            controller: homeController.searchController,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: const InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white54,
                )),
            onChanged: (value) {
              if (homeController.tabIndex == 0) {
                homeController.serachTrendingMovies(value);
              } else {
                homeController.serachTopRatedMovies(value);
              }
            },
          ),
          bottom: TabBar(
            onTap: (value) {
              homeController.changeTabIndex(value);
            },
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withOpacity(0.3),
            tabs: const [
              Tab(
                child: Text(
                  "Trending Movies",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Tab(
                child: Text(
                  "Top Rated Movies",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        body: GetBuilder<HomeController>(
          builder: (controller) {
            if (controller.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if ((homeController.trendingMoviesList.isEmpty &&
                    controller.tabIndex == 0) ||
                (homeController.topRatedMoviesList.isEmpty &&
                    controller.tabIndex == 1)) {
              return const Center(
                child: Text('No Data Found'),
              );
            } else {
              return TabBarView(children: [
                TrandingMovies(trending: homeController.trendingMoviesList),
                TopRatedMovies(toprated: homeController.topRatedMoviesList),
              ]);
            }
          },
        ),
      ),
    );
  }
}
