import 'package:flutter/material.dart';

String version = 'Unknown';

Color txtColor = const Color(0xFFAA98A9);
Color textColor = Colors.white;
Color appBarBG = Colors.black26;

BoxDecoration background = const BoxDecoration(image: DecorationImage(image: AssetImage('assets/Portrait.jpg'), fit: BoxFit.cover));

ButtonStyle style = ElevatedButton.styleFrom(
  backgroundColor: const Color.fromARGB(1, 0, 0, 0),
  foregroundColor: txtColor,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
);

void showErrorMessage(String msg, BuildContext context) {
  final snackBar = SnackBar(
    showCloseIcon: true,
    closeIconColor: txtColor,
    duration: const Duration(seconds: 5),
    backgroundColor: Colors.black,
    content: Text(msg, style: const TextStyle(color: Colors.white)),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}