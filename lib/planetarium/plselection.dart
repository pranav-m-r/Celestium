import 'package:flutter/material.dart';
import 'package:astroquest/globals.dart';
import 'package:astroquest/results/resvar.dart';

class Planetarium extends StatefulWidget {
  const Planetarium({super.key});

  @override
  State<Planetarium> createState() => _PlanetariumState();
}

class _PlanetariumState extends State<Planetarium> {
  PageController pageController = PageController();

  void topicSelected(String text) {
    resHead = text;
    Navigator.pushNamed(context, '/result');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<String> topics = [
      'Mercury',
      'Venus',
      'Earth',
      'Moon',
      'Mars',
      'Jupiter',
      'Saturn',
      'Uranus',
      'Neptune',
    ];

    Center imgButton(String text, String image) {
      return Center(
        child: GestureDetector(
            onTap: () {
              topicSelected(text);
            },
            child: Container(
              width: screenWidth * 0.9,
              height: screenHeight * 0.25,
              decoration: BoxDecoration(
                border: Border.all(
                  color: txtColor,
                  width: 1,
                ),
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.darken),
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    const Icon(
                      Icons.arrow_forward,
                      size: 27,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            )),
      );
    }

    Container plPage(int page) {
      return Container(
        decoration: background,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBar('Planetarium'),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              imgButton(topics[3 * page], "assets/${topics[3 * page]}.jpg"),
              imgButton(topics[3 * page + 1], "assets/${topics[3 * page + 1]}.jpg"),
              imgButton(topics[3 * page + 2], "assets/${topics[3 * page + 2]}.jpg"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                    style: pageBtnStyle,
                    iconSize: 30,
                    onPressed: () {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  Text(
                    'Page ${page + 1}',
                    style: const TextStyle(fontSize: 20, color: txtColor),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_forward,
                    ),
                    style: pageBtnStyle,
                    iconSize: 30,
                    onPressed: () {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return PageView(
      scrollDirection: Axis.horizontal,
      controller: pageController,
      children: <Widget>[
        plPage(0),
        plPage(1),
        plPage(2),
      ],
    );
  }
}
