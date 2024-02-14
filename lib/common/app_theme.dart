import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  fontFamily: 'Montserrat',
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
    bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.black,
    unselectedLabelColor: Colors.grey,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: Colors.black, width: 2.0),
    ),
  ),
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    elevation: 4.0,
    margin: const EdgeInsets.all(10.0),
  ),
);
