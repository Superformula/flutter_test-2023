import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:restaurantour/animated_splash_screen.dart';
import 'package:restaurantour/app/core/theme/custom_text_theme.dart';
import 'package:restaurantour/app/data/repositories/yelp_repository.dart';
import 'package:restaurantour/app/ui/pages/restaurants_page.dart';
import 'package:restaurantour/config.dart';

import 'app/core/theme/custom_icon_theme.dart';

String jsonString = '';

Future<void> main() async {
  runApp(const AnimatedSplashScreen());

  //Demonstrates the splashscreen gif using a delay
  if (!kDebugMode) {
    await Future.delayed(const Duration(seconds: 3));
  }

  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();

  try {
    jsonString = await rootBundle.loadString('assets/mock_restaurant_response.json');
  } catch (e) {
    if (kDebugMode) {
      print('Error loading mock_restaurant_response.json: $e');
    }
  }

  runApp(const Restaurantour());
}

class Restaurantour extends StatelessWidget {
  // This widget is the root of your application.
  const Restaurantour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Config.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: CustomTextTheme.textTheme,
        iconTheme: CustomIconTheme.iconTheme,
      ),
      home: const RestaurantsPage(),
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
            const Text(Config.appName),
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
