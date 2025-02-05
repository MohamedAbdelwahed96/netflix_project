import 'package:flutter/material.dart';

class ColorsManager {
  static Color mainRed = Color.fromRGBO(243, 29, 28, 1);
  static Color background = Colors.black;
  static Color text = Colors.white;

  // static void updateMainRed() {
  //   background = background == Colors.cyan.shade400
  //       ? Colors.black
  //       : Colors.cyan.shade400;
  //   text = text == Colors.cyan.shade400 ? Colors.white : Colors.black;
  // }
}

// ThemeData lightMode = ThemeData(
//     brightness: Brightness.light,
//     colorScheme: ColorScheme.light(
//         background: Colors.cyan.shade400, primary: Colors.black));
//
// ThemeData darkMode = ThemeData(
//     brightness: Brightness.dark,
//     colorScheme: ColorScheme.light(
//         background: Colors.black, primary: Colors.white));
