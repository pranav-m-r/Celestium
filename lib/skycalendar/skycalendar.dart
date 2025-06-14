import 'package:flutter/material.dart';

import '../data/themedata.dart';
import 'eventlist.dart' show selectedYear;

class SkyCalendar extends StatefulWidget {
  const SkyCalendar({super.key});

  @override
  State<SkyCalendar> createState() => _SkyCalendarState();
}

class _SkyCalendarState extends State<SkyCalendar> {
  void showEvents(String year) {
    selectedYear = year;
    Navigator.pushNamed(context, '/eventoptions');
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

    SizedBox uiButton(String txt) {
      double y = 0.09;
      return SizedBox(
        width: screenWidth * 0.45,
        height: screenHeight * y,
        child: ElevatedButton(
          style: btnStyle,
          onPressed: () {
            showEvents(txt);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(),
              Text(
                txt,
                style: fontText(23),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 23,
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar('Sky Calendar'),
        body: ListView(
          children: <Widget>[
            dspacing(),
            titleText(21, 'Upcoming Events'),
            dspacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                uiButton('2025'),
                uiButton('2026'),
              ],
            ),
            spacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                uiButton('2027'),
                uiButton('2028'),
              ],
            ),
            spacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                uiButton('2029'),
                uiButton('2030'),
              ],
            ),
            dspacing(),
            spacing(),
            titleText(21, 'Previous Events'),
            dspacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                uiButton('2024'),
                uiButton('2023'),
              ],
            ),
            spacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                uiButton('2022'),
                uiButton('2021'),
              ],
            ),
            spacing(),
          ],
        ),
      ),
    );
  }
}
