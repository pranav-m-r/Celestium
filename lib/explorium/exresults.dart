import 'package:flutter/material.dart';
import 'package:astroquest/globals.dart';

String expResHead = 'Explorium';
String expResBody1 = 'test';
String expResBody2 = 'test';
String expResBody3 = 'test';
String expImgPath1 = 'assets/Portrait.jpg';
String expImgPath2 = 'assets/Portrait.jpg';
String expImgPath3 = 'assets/Portrait.jpg';

class ExpResult extends StatefulWidget {
  const ExpResult({super.key});

  @override
  State<ExpResult> createState() => _ExpResultState();
}

class _ExpResultState extends State<ExpResult> {
  void textToSpeech(String text) {}

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double padding = screenWidth * 0.05;

    SizedBox spacing() {
      return SizedBox(height: padding * 0.8);
    }

    SizedBox dspacing() {
      return SizedBox(height: padding * 0.8 * 2);
    }

    Container image(String path) {
      return Container(
        height: screenHeight * 0.25,
        decoration: BoxDecoration(
          border: Border.all(
            color: txtColor,
            width: 1,
          ),
          image: DecorationImage(
            image: AssetImage(path),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return Container(
      decoration: background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar(expResHead),
        body: ListView(
          padding: EdgeInsets.all(padding),
          children: <Widget>[
            spacing(),
            image(expImgPath1),
            dspacing(),
            Center(
              child: SizedBox(
                height: screenWidth * 0.2,
                width: screenWidth * 0.2,
                child: IconButton(
                  icon: const Icon(
                    Icons.volume_up_rounded,
                  ),
                  style: pageBtnStyle,
                  iconSize: 50,
                  onPressed: () {
                    textToSpeech("$expResBody1\n$expResBody2\n$expResBody3");
                  },
                ),
              ),
            ),
            dspacing(),
            text(20, expResBody1),
            dspacing(),
            image(expImgPath2),
            dspacing(),
            text(20, expResBody2),
            dspacing(),
            image(expImgPath3),
            dspacing(),
            text(20, expResBody3),
            spacing(),
          ],
        ),
      ),
    );
  }
}
