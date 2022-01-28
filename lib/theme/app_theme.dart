import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData mainTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      headline4: TextStyle(
        fontSize: 32,
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        fontSize: 16,
      ),
    ),
  );
}
