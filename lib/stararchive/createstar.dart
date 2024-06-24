import 'package:flutter/material.dart';
import 'package:astroquest/globals.dart';

class CreateStar extends StatefulWidget {
  const CreateStar({super.key});

  @override
  State<CreateStar> createState() => _CreateStarState();
}

class _CreateStarState extends State<CreateStar> {

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
