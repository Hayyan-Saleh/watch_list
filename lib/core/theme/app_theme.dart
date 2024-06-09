import 'package:flutter/material.dart';

const primaryColor = Color.fromARGB(255, 245, 131, 0);
const secondaryColor = Color.fromARGB(255, 0, 236, 158);
final appTheme = ThemeData(
  appBarTheme:
      const AppBarTheme(backgroundColor: primaryColor, centerTitle: true),
  brightness: Brightness.light,
  primaryColor: primaryColor,
  colorScheme: const ColorScheme.light(primary: primaryColor),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: primaryColor),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor, foregroundColor: secondaryColor),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelStyle: const TextStyle(color: primaryColor),
    iconColor: secondaryColor,
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: primaryColor),
        borderRadius: BorderRadius.circular(8)),
  ),
);
