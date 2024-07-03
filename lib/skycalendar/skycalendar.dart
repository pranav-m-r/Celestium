import 'package:flutter/material.dart';

import '../data/globals.dart';
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
        height: screenHeight * y,
        child: ElevatedButton(
          style: btnStyle,
          onPressed: () {
            showEvents(txt);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(Icons.calendar_month, size: 27),
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

    return Container(
      decoration: background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar('Sky Calendar'),
        body: ListView(
          padding: EdgeInsets.all(padding),
          children: <Widget>[
            spacing(),
            text(20, 'Upcoming Events:'),
            dspacing(),
            uiButton('2024'),
            spacing(),
            uiButton('2025'),
            spacing(),
            uiButton('2026'),
            spacing(),
            uiButton('2027'),
            dspacing(),
            text(20, 'Past Events:'),
            dspacing(),
            uiButton('2023'),
            spacing(),
            uiButton('2022'),
            spacing(),
            uiButton('2021'),
            spacing(),
          ],
        ),
      ),
    );
  }
}
