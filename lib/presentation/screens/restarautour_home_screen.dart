import 'package:flutter/material.dart';
import '../widgets/all_restaurants_widget.dart';
import '../widgets/my_favorite_restaurants_widget.dart';

class RestauranTourHomeScreen extends StatelessWidget {
  const RestauranTourHomeScreen({super.key});

  static const titleStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'VelourRaw',
    fontWeight: FontWeight.w600,
  );
  static const titleText = 'RestauranTour';

  static const routeName = '/';

  static const tabBarAllRestaurantsText = 'All Restaurants';
  static const tabBarMyFavoritesText = 'My Favorites';

  static const appBarKey = Key('appBarKey');
  static const tabBarKey = Key('tabBarKey');

  @override
  Widget build(BuildContext context) {
    const tabBar = TabBar(
      key: tabBarKey,
      indicatorWeight: 2,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: Colors.black,
      labelColor: Colors.black,
      tabs: [
        Tab(text: tabBarAllRestaurantsText),
        Tab(text: tabBarMyFavoritesText),
      ],
    );

    final appBar = AppBar(
      key: appBarKey,
      backgroundColor: Colors.white,
      title: const Text(titleText, style: titleStyle),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 60),
          child: tabBar,
        ),
      ),
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appBar,
        body: const TabBarView(
          children: [
            AllRestaurantsWidget(),
            MyFavoritesRestaurantsWidget(),
          ],
        ),
      ),
    );
  }
}
