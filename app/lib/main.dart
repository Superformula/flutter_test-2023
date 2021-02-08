import 'package:flutter/material.dart';
import 'package:restaurantour/respositories/yelp_repository.dart';

void main() {
  runApp(RestauranTour());
}

class RestauranTour extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RestauranTour',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('RestauranTour'),
            RaisedButton(
              child: const Text('Fetch Restaurants'),
              onPressed: () async {
                final yelpRepo = YelpRepository();

                try {
                  final result = await yelpRepo.getRestaurants();
                  print('Fetched ${result.restaurants.length} restaurants');
                } catch (e) {
                  print('Failed to fetch restaurants: $e');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
