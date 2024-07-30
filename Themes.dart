// ignore_for_file: file_names

import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    color: Colors.white
    ),
  );

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xff15161a),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    color: Color(0xff15161a)
  )
);
