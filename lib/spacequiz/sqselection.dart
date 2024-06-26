import 'package:flutter/material.dart';
import 'package:astroquest/globals.dart';

class SpaceQuiz extends StatefulWidget {
  const SpaceQuiz({super.key});

  @override
  State<SpaceQuiz> createState() => _SpaceQuizState();
}

class _SpaceQuizState extends State<SpaceQuiz> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double padding = screenWidth * 0.05;

    SizedBox spacing() {
      return SizedBox(height: padding * 0.8);
    }

    return Container(
      decoration: background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
          appBar: appBar('Space Quiz'),
          body: ListView(
            padding: EdgeInsets.all(padding),
                children: <Widget>[
                  spacing(),
                ],),
              ),
            );
  }
}
