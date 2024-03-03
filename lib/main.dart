import 'package:flutter/material.dart';
import 'package:restaurantour/app.dart';
import 'package:restaurantour/core/inject.dart';
import 'package:restaurantour/core/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupInjection();
  RTLogger.i(message: 'Start app');
  runApp(const App());
}
