import 'package:flutter/material.dart';
import 'package:astroquest/globals.dart';
import 'exresults.dart';

class Explorium extends StatefulWidget {
  const Explorium({super.key});

  @override
  State<Explorium> createState() => _ExploriumState();
}

class _ExploriumState extends State<Explorium> {
  PageController pageController = PageController();

  void topicSelected(String text) {
    expResHead = text;
    Navigator.pushNamed(context, '/exresult');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<String> topics = [
      'Big Bang',
      'Universe',
      'Star Birth',
      'Nebulae',
      'Star Death',
      'Galaxies',
    ];

    List<String> images = [
      'assets/bigbang.jpg',
      'assets/universe.jpg',
      'assets/M8.jpg',
      'assets/M43.jpg',
      'assets/M82.jpg',
      'assets/M104.jpg',
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
                      Colors.black.withOpacity(0.4), BlendMode.darken),
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

    Container expPage(int page) {
      return Container(
        decoration: background,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBar('Explorium'),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              imgButton(topics[3 * page], images[3 * page]),
              imgButton(topics[3 * page + 1], images[3 * page + 1]),
              imgButton(topics[3 * page + 2], images[3 * page + 2]),
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
        expPage(0),
        expPage(1),
      ],
    );
  }
}
