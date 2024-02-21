import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'application/list_restaurants_provider.dart';
import 'config/get_it.dart';
import 'presentation/pages/package.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  setup();
  runApp(const Restaurantour());
}

class Restaurantour extends StatelessWidget {
  // This widget is the root of your application.
  const Restaurantour({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListRestaurantsProvider()),
      ],
      child: MaterialApp(
        title: 'RestauranTour',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const ListViewPage(),
      ),
    );
  }
}
