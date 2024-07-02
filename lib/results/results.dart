import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart' show FlutterTts;
import 'package:astroquest/globals.dart';
import 'resvar.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
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
      if (text.isNotEmpty) {
        await flutterTts.awaitSpeakCompletion(true);
        await flutterTts.speak(text);
        if (mounted) {
          setState(() {
            icon = Icons.volume_up_rounded;
          });
        }
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
    double padding = screenWidth * 0.05;

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
        appBar: appBar(resHead),
        body: ListView(
          padding: EdgeInsets.all(padding),
          children: <Widget>[
            spacing(),
            Container(
              width: screenWidth * 0.85,
              height: screenWidth * 0.85,
              decoration: BoxDecoration(
                border: Border.all(
                  color: txtColor,
                  width: 1,
                ),
                image: DecorationImage(
                  image: AssetImage(resImgPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: padding * 0.5),
            text(14, '(Representative Image)'),
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
                    textToSpeech(resBody
                        .split('\n')[0]
                        .replaceAll(RegExp('\\(.*?\\)'), ''));
                  },
                ),
              ),
            ),
            dspacing(),
            Text(
              resBody,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            spacing(),
          ],
        ),
      ),
    );
  }
}
