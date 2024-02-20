import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/providers/restaurantProvider.dart';
import 'package:restaurantour/screens/homeScreen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RestaurantProvider(),
      child: const Restaurantour(),
    ),
  );
}

class Restaurantour extends StatelessWidget {
  const Restaurantour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RestauranTour',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white, // Color de fondo de la barra de aplicación
        appBarTheme: AppBarTheme(
          color: Colors.white,
          toolbarTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                titleLarge: const TextStyle(
                  color: Colors
                      .black, // Color del texto del título de la barra de aplicación
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
              .bodyMedium,
          titleTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                titleLarge: const TextStyle(
                  color: Colors
                      .black, // Color del texto del título de la barra de aplicación
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
              .titleLarge,
        ),
        colorScheme: const ColorScheme(
          // Configuración de colores general
          primary: Colors.black,
          secondary: Colors.black,
          brightness: Brightness.light,
          onBackground: Colors.white,
          onPrimary: Colors.black,
          surface: Colors.white,
          onSurface: Colors.white,
          error: Colors.white,
          onError: Colors.white,
          onSecondary: Colors.white,
          background: Colors.white,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}
