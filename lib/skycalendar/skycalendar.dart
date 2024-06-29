import 'package:flutter/material.dart';
import 'package:astroquest/globals.dart';
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
            uiButton(() {
              showEvents('2024');
            }, '2024', const Icon(Icons.calendar_month_outlined, size: 27)),
            spacing(),
            uiButton(() {
              showEvents('2025');
            }, '2025', const Icon(Icons.calendar_month_outlined, size: 27)),
            spacing(),
            uiButton(() {
              showEvents('2026');
            }, '2026', const Icon(Icons.calendar_month_outlined, size: 27)),
            spacing(),
            uiButton(() {
              showEvents('2027');
            }, '2027', const Icon(Icons.calendar_month_outlined, size: 27)),
            dspacing(),
            text(20, 'Past Events:'),
            dspacing(),
            uiButton(() {
              showEvents('2023');
            }, '2023', const Icon(Icons.calendar_month_outlined, size: 27)),
            spacing(),
            uiButton(() {
              showEvents('2022');
            }, '2022', const Icon(Icons.calendar_month_outlined, size: 27)),
            spacing(),
            uiButton(() {
              showEvents('2021');
            }, '2021', const Icon(Icons.calendar_month_outlined, size: 27)),
            spacing(),
          ],
        ),
      ),
    );
  }
}
