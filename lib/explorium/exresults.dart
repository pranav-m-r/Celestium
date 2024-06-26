import 'package:flutter/material.dart';
import 'package:astroquest/globals.dart';

class ExpResult extends StatefulWidget {
  const ExpResult({super.key});

  @override
  State<ExpResult> createState() => _ExpResultState();
}

class _ExpResultState extends State<ExpResult> {

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
          appBar: appBar(expResHead),
          body: ListView(
            padding: EdgeInsets.all(padding),
                children: <Widget>[
                  spacing(),
                ],),
              ),
            );
  }
}
