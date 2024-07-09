import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' show Database;
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

String version = 'Unknown';

late Database db;

const txtColor = Color.fromARGB(255, 225, 200, 255);

BoxDecoration background = const BoxDecoration(
    image: DecorationImage(
        image: AssetImage('assets/portrait.jpg'), fit: BoxFit.cover));

ButtonStyle btnStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.black26,
    shadowColor: Colors.transparent,
    overlayColor: Colors.transparent,
    foregroundColor: txtColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(color: txtColor, width: 0.5),
    ));

ButtonStyle pageBtnStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.black26,
    shadowColor: Colors.transparent,
    overlayColor: Colors.transparent,
    foregroundColor: txtColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(color: txtColor, width: 1),
    ));

ButtonStyle dropdownStyle = ElevatedButton.styleFrom(
  foregroundColor: Colors.white,
);

Center titleText(double size, String txt) {
  return Center(
    child: Text(
      txt,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: size, fontWeight: FontWeight.w500, color: Colors.white),
    ),
  );
}

TextStyle fontText(double size, {Color color = txtColor}) {
  return GoogleFonts.orbitron(
      fontSize: size, fontWeight: FontWeight.w500, color: color);
}

AppBar appBar(String title) {
  return AppBar(
    foregroundColor: Colors.white,
    backgroundColor: Colors.black38,
    shadowColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    title: Text(title, style: GoogleFonts.orbitron()),
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
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
