import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/helpers/favorites_helper.dart';
import 'package:restaurantour/pages/home_page.dart';
import 'package:restaurantour/providers/data_provider.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

void main() {
  runApp(const Restaurantour());
}

class Restaurantour extends StatelessWidget {
  const Restaurantour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(create: (context) => FavoritesHelpers()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RestauranTour',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: const ColorScheme(
            background: Colors.white,
            brightness: Brightness.light,
            primary: Colors.black87,
            secondary: Colors.white,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            error: Colors.redAccent,
            onError: Colors.redAccent,
            onBackground: Colors.black87,
            surface: Colors.white,
            onSurface: Colors.black87,
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
