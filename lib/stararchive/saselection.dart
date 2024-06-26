import 'package:flutter/material.dart';
import 'package:astroquest/globals.dart';

class StarArchive extends StatefulWidget {
  const StarArchive({super.key});

  @override
  State<StarArchive> createState() => _StarArchiveState();
}

class _StarArchiveState extends State<StarArchive> {

  void selectStar() {
    String star = 'Star';
    resHead = star;
    Navigator.pushNamed(context, '/result');
  }

  void randomStar() {
    String star = 'Star';
    resHead = star;
    Navigator.pushNamed(context, '/result');
  }

  void createStar() {
    Navigator.pushNamed(context, '/createstar');
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
          style: style,
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
          appBar: appBar('Star Archive'),
          body: ListView(
            padding: EdgeInsets.all(padding),
                children: <Widget>[
                  spacing(),
                  text(20, 'Want data on a specific star?'),
                  dspacing(),
                  uiButton(selectStar, 'Select Star', const Icon(Icons.search, size: 27)),
                  dspacing(),
                  text(20, 'Want to create your own star?'),
                  dspacing(),
                  uiButton(createStar, 'Create Star', const Icon(Icons.create, size: 27)),
                  dspacing(),
                  text(20, 'Want to learn about a new star?'),
                  dspacing(),
                  uiButton(randomStar, 'Random Star', const Icon(Icons.casino, size: 27)),
                  spacing(),
                ],),
              ),
            );
  }
}
