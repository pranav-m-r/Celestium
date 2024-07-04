import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart' show FlutterTts;

import '../data/globals.dart';

String expResHead = 'Explorium';
String expResBody1 = 'test';
String expResBody2 = 'test';
String expResBody3 = 'test';
String expImgPath1 = 'assets/portrait.jpg';
String expImgPath2 = 'assets/portrait.jpg';
String expImgPath3 = 'assets/portrait.jpg';

class ExpResult extends StatefulWidget {
  const ExpResult({super.key});

  @override
  State<ExpResult> createState() => _ExpResultState();
}

class _ExpResultState extends State<ExpResult> {
  late FlutterTts flutterTts;
  IconData icon = Icons.volume_up_rounded;

  @override
  initState() {
    super.initState();
    flutterTts = FlutterTts();
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  void textToSpeech(String text) async {
    if (icon == Icons.volume_up_rounded) {
      setState(() {
        icon = Icons.volume_off_rounded;
      });
      await flutterTts.awaitSpeakCompletion(true);
      await flutterTts.speak(text);
      if (mounted) {
        setState(() {
          icon = Icons.volume_up_rounded;
        });
      }
    } else {
      setState(() {
        icon = Icons.volume_up_rounded;
      });
      await flutterTts.stop();
    }
  }

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

    Text resText(txt) {
      return Text(
        txt,
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      );
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
                  icon: Icon(icon),
                  style: pageBtnStyle,
                  iconSize: 50,
                  onPressed: () {
                    textToSpeech(("$expResBody1 $expResBody2 $expResBody3")
                        .replaceAll(RegExp('\\(.*?\\)'), ''));
                  },
                ),
              ),
            ),
            dspacing(),
            resText(expResBody1),
            dspacing(),
            image(expImgPath2),
            dspacing(),
            resText(expResBody2),
            dspacing(),
            image(expImgPath3),
            dspacing(),
            resText(expResBody3),
            spacing(),
          ],
        ),
      ),
    );
  }
}
