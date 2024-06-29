import 'package:flutter/material.dart';
import 'package:astroquest/globals.dart';
import 'package:astroquest/results/resvar.dart';

String selectedYear = '2024';
List<String> events = [];

class EventOptions extends StatefulWidget {
  const EventOptions({super.key});

  @override
  State<EventOptions> createState() => _EventOptionsState();
}

class _EventOptionsState extends State<EventOptions> {
  void initList() async {
    List<Map> list = await db.query('sc$selectedYear', columns: ['event']);
    events = [];
    setState(() {
      for (int i = 0; i < list.length; i++) {
        if (!events.contains(list[i]['event'])) {
          events.add(list[i]['event']);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initList();
  }

  void eventResult(String event) async {
    List<Map> list = await db
        .query('sc$selectedYear', where: 'event = ?', whereArgs: [event]);

    resHead = event.split(' - ')[0];
    resBody = "${event.split(' - ')[1]}: ${list[0]['desc']}";

    if (event.toLowerCase().contains('mercury')) {
      resImgPath = 'assets/MercurySS.jpg';
    } else if (event.toLowerCase().contains('venus')) {
      resImgPath = 'assets/VenusSS.jpg';
    } else if (event.toLowerCase().contains('mars')) {
      resImgPath = 'assets/MarsSS.jpg';
    } else if (event.toLowerCase().contains('jupiter')) {
      resImgPath = 'assets/JupiterSS.jpg';
    } else if (event.toLowerCase().contains('saturn')) {
      resImgPath = 'assets/SaturnSS.jpg';
    } else if (event.toLowerCase().contains('uranus')) {
      resImgPath = 'assets/UranusSS.jpg';
    } else if (event.toLowerCase().contains('neptune')) {
      resImgPath = 'assets/NeptuneSS.jpg';
    } else if (event.toLowerCase().contains('moon')) {
      resImgPath = 'assets/MoonSS.jpg';
    } else if (event.toLowerCase().contains('solstice') ||
        event.toLowerCase().contains('equinox')) {
      resImgPath = 'assets/RedGiant.jpg';
    } else if (event.toLowerCase().contains('lunar')) {
      resImgPath = 'assets/le.jpg';
    } else if (event.toLowerCase().contains('solar')) {
      resImgPath = 'assets/se.jpg';
    } else if (event.toLowerCase().contains('asteroid')) {
      resImgPath = 'assets/asteroids.jpg';
    } else if (event.toLowerCase().contains('meteor') ||
        event.toLowerCase().contains('comet')) {
      resImgPath = 'assets/Comet.jpg';
    } else {
      resImgPath = 'assets/BinaryStar.jpg';
    }

    if (mounted) Navigator.pushNamed(context, '/result');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double padding = screenWidth * 0.05;

    SizedBox uiButton(void Function() fxn, String txt) {
      double y = 0.08;
      return SizedBox(
        height: screenHeight * y,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              overlayColor: Colors.transparent,
              foregroundColor: txtColor),
          onPressed: fxn,
          child: Text(
            txt,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Container(
      decoration: background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar('Sky Calendar'),
        body: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: padding * 0.5, vertical: padding * 0.3),
              child: GestureDetector(
                onTap: () {
                  eventResult(events[index]);
                },
                child: ListTile(
                  title:
                      Text(events[index], style: const TextStyle(fontSize: 18)),
                  textColor: txtColor,
                  tileColor: Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: txtColor, width: 0.5),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
