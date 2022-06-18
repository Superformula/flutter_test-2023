import 'package:flutter/material.dart';
import 'package:restaurantour/theme/app_color.dart';

class RestauranTour extends StatelessWidget {
  const RestauranTour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelColor: AppColors.primaryFill,
            unselectedLabelColor: AppColors.secondaryText,
            labelStyle: Theme.of(context).textTheme.bodyText2,
            unselectedLabelStyle: Theme.of(context).textTheme.bodyText2,
            tabs: const [
              Tab(
                text: "All Resturants",
              ),
              Tab(
                text: "My Favorites",
              ),
            ],
          ),
          title: Text(
            "RestauranTour",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: const TabBarView(
          children: [
            Text("Rest list"),
            Text("Favurites list"),
          ],
        ),
      ),
    );
  }
}
