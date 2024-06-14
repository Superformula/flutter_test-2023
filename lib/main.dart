import 'package:flutter/material.dart';
import 'package:restaurantour/app.dart';

import 'service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const App());
}
