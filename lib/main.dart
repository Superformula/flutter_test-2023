import 'package:flutter/material.dart';
import 'package:restaurantour/app.dart';
import 'package:restaurantour/core/inject.dart';
import 'package:restaurantour/core/logger.dart';

const String kAppFlavor = String.fromEnvironment('app.flavor', defaultValue: "prod");

const String kFlavorStage = "stage";
const String kFlavorProd = "prod";
const String kFlavorLocal = "local";

const bool kIsStage = kAppFlavor == kFlavorStage;
const bool kIsProd = kAppFlavor == kFlavorProd;
const bool kIsLocal = kAppFlavor == kFlavorLocal;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsStage) RTLogger.d(message: 'Running in Stage mode');
  if (kIsProd) RTLogger.w(message: 'Running in Prod mode');
  if (kIsLocal) RTLogger.i(message: 'Running in Local mode');

  await setupInjection();

  RTLogger.i(message: 'Start app');
  runApp(const App());
}
