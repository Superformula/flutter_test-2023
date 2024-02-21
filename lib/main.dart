import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/app_state.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';
import 'package:restaurantour/resources/resources_exports.dart';
import 'package:restaurantour/resources/routes_manager.dart';
import 'package:restaurantour/resources/theme_manager.dart';

void main() async {
  final appState = AppState(); // Initialize FFAppState
  await dotenv.load();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => appState)],
      child: const Restaurantour(),
    ),
  );
}

class Restaurantour extends StatelessWidget {
  const Restaurantour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        title: AppStrings.appName,
        theme: getApplicationTheme(false, context),
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.homeRoute,
        debugShowCheckedModeBanner: false,
      ),
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
