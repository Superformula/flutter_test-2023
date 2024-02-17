import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurantour/theme/style.dart';

showToast(String text, {bool error = false}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 1,
    backgroundColor: error ? Colors.red : accentColor,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
