import 'package:flutter/material.dart';
import 'package:movies_app/utils/components/custom_text.dart';
import 'package:movies_app/utils/components/discription.dart';
import 'package:movies_app/widgets/custom_card.dart';
import 'package:velocity_x/velocity_x.dart';

class TrandingMovies extends StatelessWidget {
  final List trending;

  const TrandingMovies({Key? key, required this.trending}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'Trending Movies',
            size: 26,
          ),
          10.heightBox,
          Expanded(
            child: ListView.builder(
              itemCount: trending.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Description(
                          name: trending[index]['title'],
                          bannerurl:
                              'https://image.tmdb.org/t/p/w500${trending[index]['backdrop_path']}',
                          posterurl:
                              'https://image.tmdb.org/t/p/w500${trending[index]['poster_path']}',
                          description: trending[index]['overview'],
                          vote: trending[index]['vote_average'].toString(),
                          releaseDate: trending[index]['release_date'],
                        ),
                      ),
                    );
                  },
                  child: CustomCard(
                    image:
                        'https://image.tmdb.org/t/p/w500${trending[index]['poster_path']}',
                    name: trending[index]['title'],
                    date: trending[index]['release_date'],
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
