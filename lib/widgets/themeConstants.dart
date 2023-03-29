import 'package:flutter/material.dart';
import 'package:solution_challenge_v1/main.dart';

ThemeData lightTheme = ThemeData(
  canvasColor: Color.fromRGBO(241, 254, 255, 1),
  appBarTheme: const AppBarTheme(
    color: Color.fromRGBO(246, 145, 138, 1),
    titleTextStyle: TextStyle(fontSize: 24),
    iconTheme: IconThemeData(
      color: Colors.black, //change your color here
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
      .copyWith(secondary: Colors.black),
);

ThemeData darkTheme = ThemeData(
  canvasColor: Color.fromRGBO(50, 49, 49, 1),
  appBarTheme: const AppBarTheme(
    color: Color.fromRGBO(255, 189, 183, 1),
    titleTextStyle: TextStyle(fontSize: 24),
    iconTheme: IconThemeData(
      color: Colors.white, //change your color here
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
      .copyWith(secondary: Color.fromARGB(255, 48, 48, 48)),
);
