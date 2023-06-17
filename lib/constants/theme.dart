import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.red,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.red,
        disabledBackgroundColor: Colors.red.withOpacity(0.38),
        textStyle: const TextStyle(
          color: Colors.black,
        ),
        side: BorderSide(
          color: Colors.red.withOpacity(0.9),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: outlineInputBorder,
      errorBorder: outlineInputBorder,
      enabledBorder: outlineInputBorder,
      prefixIconColor: Colors.grey,
      focusedBorder: outlineInputBorder,
      disabledBorder: outlineInputBorder,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            textStyle: const TextStyle(
              fontSize: 18,
            ),
          disabledBackgroundColor: Colors.grey,
        ),
    ),
  primarySwatch: Colors.green,
    canvasColor:  Colors.red,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    toolbarTextStyle: TextStyle(
      color: Colors.black
    ),
    iconTheme: IconThemeData(color: Colors.black)
  )
);


OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, style: BorderStyle.solid));
