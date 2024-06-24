import 'package:flutter/material.dart';
import 'package:astroquest/globals.dart';

class Explorium extends StatefulWidget {
  const Explorium({super.key});

  @override
  State<Explorium> createState() => _ExploriumState();
}

class _ExploriumState extends State<Explorium> {

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
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: appBarBG,
            title: const Text('Planetarium'),
            centerTitle: true,
          ),
          body: ListView(
            padding: EdgeInsets.all(padding),
                children: <Widget>[
                  spacing(),
                ],),
              ),
            );
  }
}
