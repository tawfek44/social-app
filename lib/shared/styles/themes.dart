import 'package:flutter/material.dart';
import 'color.dart';
ThemeData lightTheme = ThemeData(
   primarySwatch: mainColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: mainColor,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        elevation: 20.0,

    ),
);
