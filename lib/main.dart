import 'package:flutter/material.dart';
import 'package:restaurantour/screens/tabs/tabs_screen.dart';

void main() {
  runApp(const Restaurantour());
}

class Restaurantour extends StatelessWidget {
  // This widget is the root of your application.
  const Restaurantour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RestauranTour',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        navigationBarTheme:
        const NavigationBarThemeData(backgroundColor: Colors.white),
        floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Colors.grey),
        scaffoldBackgroundColor: Colors.white,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          secondary: Colors.grey,
          primary: Colors.green,
          onPrimary: Colors.black87,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabsScreen();
  }
}
