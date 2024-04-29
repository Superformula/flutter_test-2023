import 'package:flutter/material.dart';
import 'package:restaurantour/app_router.dart';
import 'package:yelp_repository/yelp_repository.dart';

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
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => AppRouter.generateRoute(
        settings,
        yelpRepository: YelpRepository(),
      ),
      initialRoute: PageName.restaurantList,
    );
  }
}
