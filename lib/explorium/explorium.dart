import 'package:flutter/material.dart';

import '../data/themedata.dart';
import 'exresults.dart';
import 'expdata.dart';

class Explorium extends StatefulWidget {
  const Explorium({super.key});

  @override
  State<Explorium> createState() => _ExploriumState();
}

class _ExploriumState extends State<Explorium> {
  final pageController = PageController();
  int currentPage = 0;

  void topicSelected(String text) async {
    expResHead = text;
    List<Map> list = await db.query('explorium',
        columns: ['para1', 'para2', 'para3', 'img1', 'img2', 'img3'],
        where: 'topic = ?',
        whereArgs: [text]);
    expResBody1 = list[0]['para1'];
    expResBody2 = list[0]['para2'];
    expResBody3 = list[0]['para3'];
    expImgPath1 = "assets/${list[0]['img1']}.jpg";
    expImgPath2 = "assets/${list[0]['img2']}.jpg";
    expImgPath3 = "assets/${list[0]['img3']}.jpg";
    if (mounted) await precacheImage(Image.asset(expImgPath2).image, context);
    if (mounted) await precacheImage(Image.asset(expImgPath3).image, context);
    if (mounted) Navigator.pushNamed(context, '/exresult');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double padding = screenWidth * 0.05;

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
                  image: AssetImage("assets/$image.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: fontText(24, color: Colors.white),
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 24,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            )),
      );
    }

    Column expPage(int page) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          imgButton(topics[3 * page], images[3 * page]),
          imgButton(topics[3 * page + 1], images[3 * page + 1]),
          imgButton(topics[3 * page + 2], images[3 * page + 2]),
        ],
      );
    }

    return Container(
        decoration: background,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: appBar('Explorium'),
            body: Column(
              children: [
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: pageController,
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    children: <Widget>[
                      expPage(0),
                      expPage(1),
                      expPage(2),
                      expPage(3),
                      expPage(4),
                      expPage(5),
                    ],
                  ),
                ),
                SizedBox(height: padding * 0.4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                      ),
                      style: pageBtnStyle,
                      iconSize: 26,
                      onPressed: () {
                        if (pageController.page == 0) {
                          pageController.animateToPage(5,
                              duration: const Duration(milliseconds: 1250),
                              curve: Curves.easeInOut);
                        } else {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                    Text(
                      'Page ${currentPage + 1}',
                      style: fontText(20),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_rounded,
                      ),
                      style: pageBtnStyle,
                      iconSize: 26,
                      onPressed: () {
                        if (pageController.page == 5) {
                          pageController.animateToPage(0,
                              duration: const Duration(milliseconds: 1250),
                              curve: Curves.easeInOut);
                        } else {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: padding * 0.8),
              ],
            )));
  }
}
