import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantour/presentation/views/favourite_restaurants/favourite_restaurants_page.dart';
import 'package:restaurantour/presentation/views/all_restaurants/all_restaurants_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedRoute = "/all-restaurants";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'RestaurantTour',
            style: GoogleFonts.lora(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          bottom: const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black54,
            indicatorColor: Colors.black,
            tabs: [
              Tab(text: "All Restaurants"),
              Tab(text: "My Favourites"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AllRestaurantsPage(),
            FavouriteRestaurantsPage(),
          ],
        ),
      ),
    );
  }
}
