import 'package:flutter/material.dart';
import 'package:restaurantour/presentation/app/router/app_router.dart';
import 'package:restaurantour/presentation/app/themes/themes.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

void main() {
  runApp(const Restaurantour());
}

class Restaurantour extends StatefulWidget {
  // This widget is the root of your application.
  const Restaurantour({Key? key}) : super(key: key);

  @override
  State<Restaurantour> createState() => _RestaurantourState();
}

class _RestaurantourState extends State<Restaurantour> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'RestauranTour',
      theme: lightAppThemeData(),
      routerConfig: _appRouter.routes,
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
                final yelpRepo = YelpRepository();

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
