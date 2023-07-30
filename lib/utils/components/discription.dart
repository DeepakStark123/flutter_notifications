import 'package:flutter/material.dart';
import 'package:movies_app/utils/components/custom_text.dart';

class Description extends StatelessWidget {
  final String name, description, bannerurl, posterurl, vote, releaseDate;

  const Description(
      {Key? key,
      required this.name,
      required this.description,
      required this.bannerurl,
      required this.posterurl,
      required this.vote,
      required this.releaseDate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        child: ListView(children: [
          SizedBox(
              height: 250,
              child: Stack(children: [
                Positioned(
                  child: SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      bannerurl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    bottom: 10,
                    child: CustomText(
                      text: 'Average Rating - $vote',
                      color: Colors.white,
                    )),
                Positioned(
                  top: 5,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ])),
          const SizedBox(height: 15),
          Container(
              padding: const EdgeInsets.all(10),
              child: CustomText(
                  text: name.toString() != "null" ? name : 'Not Loaded',
                  size: 24)),
          Container(
              padding: const EdgeInsets.only(left: 10),
              child: CustomText(text: 'Releasing On - $releaseDate', size: 14)),
          Row(
            children: [
              SizedBox(
                height: 200,
                width: 100,
                child: Image.network(posterurl),
              ),
              Flexible(
                child: Container(
                    padding: const EdgeInsets.all(10),
                    child: CustomText(text: description, size: 18)),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
