import 'package:flutter/material.dart';

import '../data/globals.dart';
import '../results/resvar.dart';

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
      resImgPath = 'assets/mercuryimg.jpg';
    } else if (event.toLowerCase().contains('venus')) {
      resImgPath = 'assets/venusimg.jpg';
    } else if (event.toLowerCase().contains('mars')) {
      resImgPath = 'assets/marsimg.jpg';
    } else if (event.toLowerCase().contains('jupiter')) {
      resImgPath = 'assets/jupiterimg.jpg';
    } else if (event.toLowerCase().contains('saturn')) {
      resImgPath = 'assets/saturnimg.jpg';
    } else if (event.toLowerCase().contains('uranus')) {
      resImgPath = 'assets/uranusimg.jpg';
    } else if (event.toLowerCase().contains('neptune')) {
      resImgPath = 'assets/neptuneimg.jpg';
    } else if (event.toLowerCase().contains('moon')) {
      resImgPath = 'assets/moonimg.jpg';
    } else if (event.toLowerCase().contains('solstice') ||
        event.toLowerCase().contains('equinox')) {
      resImgPath = 'assets/redgiant.jpg';
    } else if (event.toLowerCase().contains('lunar')) {
      resImgPath = 'assets/le.jpg';
    } else if (event.toLowerCase().contains('solar')) {
      resImgPath = 'assets/se.jpg';
    } else if (event.toLowerCase().contains('asteroid')) {
      resImgPath = 'assets/asteroids.jpg';
    } else if (event.toLowerCase().contains('meteor') ||
        event.toLowerCase().contains('comet')) {
      resImgPath = 'assets/comet.jpg';
    } else {
      resImgPath = 'assets/binarystar.jpg';
    }

    if (mounted) Navigator.pushNamed(context, '/result');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double padding = screenWidth * 0.05;

    return Container(
      decoration: background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar('Sky Calendar'),
        body: Material(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          child: ListView.builder(
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
                    title: Text(events[index],
                        style: const TextStyle(fontSize: 18)),
                    textColor: Colors.white,
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
      ),
    );
  }
}
