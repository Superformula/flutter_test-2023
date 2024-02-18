import 'package:flutter/material.dart';
import 'package:restaurantour/core/inject.dart';
import 'package:restaurantour/restauran_tour.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjection();

  runApp(const RestauranTour());
}
