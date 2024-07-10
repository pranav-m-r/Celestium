import 'package:flutter/material.dart';

import '../data/themedata.dart';
import 'quizpage.dart' show quizTopic;

class SpaceQuiz extends StatefulWidget {
  const SpaceQuiz({super.key});

  @override
  State<SpaceQuiz> createState() => _SpaceQuizState();
}

class _SpaceQuizState extends State<SpaceQuiz> {
  void startQuiz(String topic) {
    quizTopic = topic;
    Navigator.pushNamed(context, '/quizscreen');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double padding = screenWidth * 0.05;

    Padding uiButton(String txt) {
      double y = 0.09;
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
        child: SizedBox(
          height: screenHeight * y,
          child: ElevatedButton(
            style: btnStyle,
            onPressed: () {
              startQuiz(txt);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(),
                Text(
                  txt,
                  style: fontText(24),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      );
    }

    SizedBox spacing() {
      return SizedBox(height: padding * 0.8);
    }

    SizedBox dspacing() {
      return SizedBox(height: padding * 0.8 * 2);
    }

    return Container(
      decoration: background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar('Space Quizzer'),
        body: ListView(
          padding: EdgeInsets.all(padding),
          children: <Widget>[
            spacing(),
            titleText(22, 'Choose a topic'),
            dspacing(),
            uiButton('Our Universe - I'),
            spacing(),
            uiButton('Our Universe - II'),
            spacing(),
            uiButton('Life of Stars - I'),
            spacing(),
            uiButton('Life of Stars - II'),
            spacing(),
            uiButton('Extreme Stars - I'),
            spacing(),
            uiButton('Extreme Stars - II'),
            spacing(),
            uiButton('Black Holes - I'),
            spacing(),
            uiButton('Black Holes - II'),
            spacing(),
            uiButton('Light & Time - I'),
            spacing(),
            uiButton('Light & Time - II'),
            spacing(),
            uiButton('Star Clusters - I'),
            spacing(),
            uiButton('Star Clusters - II'),
            spacing(),
          ],
        ),
      ),
    );
  }
}
