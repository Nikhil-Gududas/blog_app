import 'package:flutter/material.dart';

class MyThemes {
  static TextStyle headline1 = const TextStyle(
      fontFamily: 'NoeDisplay', fontSize: 28, fontWeight: FontWeight.bold);
  static TextStyle headlineLarge = const TextStyle(
      fontFamily: 'NoeDisplay', fontSize: 45, fontWeight: FontWeight.bold);
  static ThemeData themeData = ThemeData(
    fontFamily: 'Poppins',
    primarySwatch: Colors.green,
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green),
          borderRadius: BorderRadius.circular(12)),
      isDense: true,
      focusColor: Colors.amber,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    canvasColor: Color(0xff121212),
    brightness: Brightness.dark,
    textTheme: TextTheme(headline1: headline1, headlineLarge: headlineLarge),
  );
}
