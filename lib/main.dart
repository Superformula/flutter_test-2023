import 'package:flutter/material.dart';
import 'package:restaurantour/core/app_init.dart';
import 'package:restaurantour/core/navigation/route_navigator.dart';

Future<void> main() async {
  AppInit.initializeApp();

  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const RestauranTour(),
  );
}

class RestauranTour extends StatelessWidget {
  const RestauranTour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'RestauranTour',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
