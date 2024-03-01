import 'package:flutter/material.dart';
import 'package:restaurantour/data/repositories/yelp_repository.dart';
import 'package:restaurantour/presentation/restaurantour.dart';
import 'package:restaurantour/secrets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Secrets.init();
  runApp(const RestaurantourApp());
}

class RestaurantourApp extends StatelessWidget {
  // This widget is the root of your application.
  const RestaurantourApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RestauranTour',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Restaurantour'),
            ElevatedButton(
              child: const Text('Fetch Restaurants'),
              onPressed: () async {
                final yelpRepo = YelpRepository(apiKey: await Secrets.apiKey);

                try {
                  final result = await yelpRepo.getRestaurants();
                  if (result != null) {
                    print('Fetched ${result.restaurants!.length} restaurants');
                  } else {
                    print('No restaurants fetched');
                  }
                } catch (e) {
                  print('Failed to fetch restaurants: $e');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
