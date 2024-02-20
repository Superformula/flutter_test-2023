import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'application/list_restaurants_provider.dart';
import 'presentation/pages/list_page.dart';
import 'repositories/yelp_repository.dart';

void main() async {
  await dotenv.load(fileName: ".env");
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
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                    if (context.mounted) {
                      context
                          .read<ListRestaurantsProvider>()
                          .addRestaurants(result.restaurants!);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ListViewPage(),
                        ),
                      );
                    }
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
