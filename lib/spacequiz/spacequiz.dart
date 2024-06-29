import 'package:flutter/material.dart';
import 'package:astroquest/globals.dart';
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

    SizedBox uiButton(void Function() fxn, String txt, Widget icon) {
      double y = 0.09;
      return SizedBox(
          height: screenHeight * y,
          child: ElevatedButton(
            style: btnStyle,
            onPressed: fxn,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                icon,
                Text(
                  txt,
                  style: const TextStyle(fontSize: 25),
                ),
                const Icon(
                  Icons.arrow_forward,
                  size: 27,
                ),
              ],
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
            text(20, 'Choose a topic:'),
            dspacing(),
            uiButton(() {
              startQuiz('Our Universe - I');
            }, 'Our Universe - I', const Icon(Icons.quiz_outlined, size: 27)),
            spacing(),
            uiButton(() {
              startQuiz('Our Universe - II');
            }, 'Our Universe - II', const Icon(Icons.quiz_outlined, size: 27)),
            spacing(),
            uiButton(() {
              startQuiz('Life of Stars - I');
            }, 'Life of Stars - I', const Icon(Icons.quiz_outlined, size: 27)),
            spacing(),
            uiButton(() {
              startQuiz('Life of Stars - II');
            }, 'Life of Stars - II', const Icon(Icons.quiz_outlined, size: 27)),
            spacing(),
            uiButton(() {
              startQuiz('Extreme Stars - I');
            }, 'Extreme Stars - I', const Icon(Icons.quiz_outlined, size: 27)),
            spacing(),
            uiButton(() {
              startQuiz('Extreme Stars - II');
            }, 'Extreme Stars - II', const Icon(Icons.quiz_outlined, size: 27)),
            spacing(),
            uiButton(() {
              startQuiz('Black Holes - I');
            }, 'Black Holes - I', const Icon(Icons.quiz_outlined, size: 27)),
            spacing(),
            uiButton(() {
              startQuiz('Black Holes - II');
            }, 'Black Holes - II', const Icon(Icons.quiz_outlined, size: 27)),
            spacing(),
            uiButton(() {
              startQuiz('Light & Time - I');
            }, 'Light & Time - I', const Icon(Icons.quiz_outlined, size: 27)),
            spacing(),
            uiButton(() {
              startQuiz('Light & Time - II');
            }, 'Light & Time - II', const Icon(Icons.quiz_outlined, size: 27)),
            spacing(),
            uiButton(() {
              startQuiz('Star Clusters - I');
            }, 'Star Clusters - I', const Icon(Icons.quiz_outlined, size: 27)),
            spacing(),
            uiButton(() {
              startQuiz('Star Clusters - II');
            }, 'Star Clusters - II', const Icon(Icons.quiz_outlined, size: 27)),
            spacing(),
          ],
        ),
      ),
    );
  }
}
