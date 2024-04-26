import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantour/pages/home/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 4,
          centerTitle: true,
          title: Text(
            'Restaurantour',
            style: GoogleFonts.lora(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.0),
              insets: EdgeInsets.symmetric(horizontal: 48.0),
            ),
            indicatorPadding: EdgeInsets.only(bottom: 8),
            tabs: [
              Tab(text: "All restaurants"),
              Tab(text: 'My Favorites'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AllRestaurantList(),
            FavoriteList(),
          ],
        ),
      ),
    );
  }
}
