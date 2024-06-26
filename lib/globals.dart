import 'package:flutter/material.dart';

String version = 'Unknown';

const txtColor = Color.fromARGB(255, 225, 200, 255);

BoxDecoration background = const BoxDecoration(
    image: DecorationImage(
        image: AssetImage('assets/Portrait.jpg'), fit: BoxFit.cover));

String resHead = 'Result';
String resBody = 'test';
String resImgPath = 'assets/Portrait.jpg';

String expResHead = 'Explorium';

ButtonStyle style = ElevatedButton.styleFrom(
    backgroundColor: Colors.black26,
    shadowColor: Colors.transparent,
    overlayColor: Colors.transparent,
    foregroundColor: txtColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(color: txtColor, width: 0.5),
    ));

Center text(double size, String txt) {
  return Center(
    child: Text(
      txt,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: size, color: Colors.white),
    ),
  );
}

AppBar appBar(String title) {
  return AppBar(
    foregroundColor: Colors.white,
    backgroundColor: Colors.black38,
    shadowColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    title: Text(title),
    centerTitle: true,
  );
}

void showErrorMessage(String msg, BuildContext context) {
  final snackBar = SnackBar(
    showCloseIcon: true,
    closeIconColor: txtColor,
    duration: const Duration(seconds: 5),
    backgroundColor: Colors.black54,
    content: Text(msg, style: const TextStyle(color: Colors.white)),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
