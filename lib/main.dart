/// Copyright 2022 - Superformula. All rights reserved.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/utils/properties.dart';
import 'package:restaurantour/providers/restaurantsprovider.dart';
import 'package:restaurantour/widgets/allrestaurants.dart';
import 'package:restaurantour/widgets/favouriterestaurants.dart';
import 'package:restaurantour/widgets/restaurantdetails.dart';

///Start method - which is the main
/// This is going to call the StatelessWidget
/// runApp is the driver of the App
void main() => runApp(RestaurantHome());

/// This is the Home widget for the Restaurant .
/// A widget that does not require mutable state as we use Provider.
/// Define the ChangeNotifierProvider Widget as a root so that all widgets can use
/// Define the Routes which will by managed by the Navigator
class RestaurantHome extends StatelessWidget {
  const RestaurantHome({Key? key}) : super(key: key);

  /// Providers are above [RestaurantHome] instead of inside it, so that all Widgets
  /// can use [RestaurantHome] while mocking the providers
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantsProvider>(
        key: Key("RestaurantProvider"),
        create: (context) => RestaurantsProvider(),
        builder: (context, child) {
          return MaterialApp(
            key: Key("RestaurantTour"),
            debugShowCheckedModeBanner: false,
            title: appTitle,
            theme: ThemeData(
              fontFamily: "Lora",
              visualDensity: VisualDensity.adaptivePlatformDensity,
              primarySwatch: white,
            ),
            initialRoute: '/allrestaurants',
            routes: {
              '/allrestaurants': (context) => const RestaurantHomePage(),
              '/restaurantdetails': (context) => const RestaurantDetails(),
            },
            home: const RestaurantHomePage(),
          );
        });
  }
}

/// This is the Home widget Page for the Restaurant .
/// A widget that does not require mutable state as we use Provider.
/// Define the ChangeNotifierProvider Widget as a root so that all widgets can use
/// Define Tabs to show the All and Favourite Restaurants
class RestaurantHomePage extends StatelessWidget {
  const RestaurantHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final resModel = Provider.of<RestaurantsProvider>(context, listen: false);
    resModel.loadAllRestaurants();
    return DefaultTabController(
        key: Key("AllRestaurantsHome"),
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(appTitle,
                style: TextStyle(
                  fontSize: 18.0,
                )),
            bottom: const TabBar(
              indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(text: "All Restaurants"),
                Tab(text: "My Favourites"),
              ],
            ),
          ),
          body: const TabBarView(
            key: Key("RestaurantsTabView"),
            children: [
              AllRestaurants(),
              FavouriteRestaurants(),
            ],
          ),
        ));
  }
}

/*
class Restaurantour extends StatelessWidget {
  // This widget is the root of your application.
  const Restaurantour({Key? key}) : super(key: key);

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
      appBar: AppBar(
        title: Text("Restaurantour"),
      ),
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
            )
          ],
        ),
      ),
    );
  }
}
*/
