import 'package:flutter/material.dart';

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromRGBO(221, 226, 232, 1),
    colorScheme: const ColorScheme.light(),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
    ),
    primaryColor: Colors.white,
    secondaryHeaderColor: const Color.fromRGBO(221, 226, 232, 1),
    highlightColor: const Color.fromRGBO(0, 95, 117, 1),
    hintColor: const Color.fromARGB(162, 0, 66, 81),
    focusColor: const Color.fromRGBO(0, 95, 117, 1),
    
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 38, 129, 149),
    colorScheme: const ColorScheme.dark(),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromRGBO(0, 95, 117, 1),
    ),
    primaryColor: const Color.fromARGB(223, 214, 219, 223),
    secondaryHeaderColor: const Color.fromARGB(233, 92, 135, 159),
    highlightColor: const Color.fromARGB(255, 0, 66, 81),
    hintColor: const Color.fromARGB(162, 0, 66, 81),
    focusColor: const Color.fromARGB(223, 214, 219, 223),
  );
}
