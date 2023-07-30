import 'package:flutter/material.dart';
import 'package:movies_app/utils/components/custom_text.dart';
import 'package:movies_app/utils/components/discription.dart';
import 'package:movies_app/widgets/custom_card.dart';
import 'package:velocity_x/velocity_x.dart';

class TopRatedMovies extends StatelessWidget {
  final List toprated;

  const TopRatedMovies({Key? key, required this.toprated}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'Top Rated Movies',
            size: 26,
          ),
          10.heightBox,
          Expanded(
            child: ListView.builder(
              itemCount: toprated.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Description(
                                  name: toprated[index]['title'],
                                  bannerurl:
                                      'https://image.tmdb.org/t/p/w500${toprated[index]['backdrop_path']}',
                                  posterurl:
                                      'https://image.tmdb.org/t/p/w500${toprated[index]['poster_path']}',
                                  description: toprated[index]['overview'],
                                  vote: toprated[index]['vote_average']
                                      .toString(),
                                  releaseDate: toprated[index]['release_date'],
                                )));
                  },
                  child: CustomCard(
                    image:
                        'https://image.tmdb.org/t/p/w500${toprated[index]['poster_path']}',
                    name: toprated[index]['title'],
                    date: toprated[index]['release_date'],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
