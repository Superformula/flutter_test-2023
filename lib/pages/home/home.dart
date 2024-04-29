import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantour/localization/localization.dart';
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
            context.l10n.appTitle,
            style: GoogleFonts.lora(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.0),
              insets: EdgeInsets.symmetric(horizontal: 48.0),
            ),
            indicatorPadding: const EdgeInsets.only(bottom: 8),
            tabs: [
              Tab(text: context.l10n.allRestaurants),
              Tab(text: context.l10n.myFavorites),
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
