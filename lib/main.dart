import 'package:flutter/material.dart';
import 'package:restaurantour/restaurantour_app.dart';
import 'package:restaurantour/injection_container.dart' as injection;

void main() async {
  await injection.init();

  runApp(const Restaurantour());
}
