import 'package:flutter/material.dart';
import 'package:restaurantour/all_restaurants/all_restaurants_main.dart';
import 'package:restaurantour/common_widgets/fetch_error_restaurants.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/my_favorites/my_favorites_main.dart';
import 'package:restaurantour/my_favorites/no_favorites_data.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';
import 'package:restaurantour/theme/app_color.dart';
import 'package:restaurantour/extensions/async_extension.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp>  with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<MainApp> {
  final GlobalKey<MyFavoritesMainState> myFavoriteKey = GlobalKey<MyFavoritesMainState>();

  late TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    _controller = TabController(length: 2,vsync: this);
    _controller.addListener(() {
      // To set up tab text color
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: SizedBox(
              // Set tab bar value with dynamic screen.
              width: MediaQuery.of(context).size.width * 0.72,
              child: TabBar(
                controller: _controller,
                tabs: [
                  tabItem(theme,"All Restaurants",0),
                  tabItem(theme,"My Favorites",1)
                ],
              ),
            ),
          ),
          title: Center(child: Text('RestauranTour', style: theme.textTheme.headline6,)),
          toolbarHeight: 90
      ),
      body: FutureBuilder<RestaurantQueryResult?>(
        future: YelpRepository().getRestaurants(),
        builder: (BuildContext context, AsyncSnapshot<RestaurantQueryResult?> snapshot) {
          return TabBarView(
            controller: _controller,
            children: [
              allRestaurantsPage(theme,snapshot),
              myFavoritesPage(theme,snapshot),
            ],
          );
        },
      ),
    );
  }

  Widget allRestaurantsPage(ThemeData theme, AsyncSnapshot<RestaurantQueryResult?> snapshot) {
    if (snapshot.hasRestaurantData()) { // show restaurant page with data.
      return AllRestaurantsMain(false,myFavoriteKey,theme,snapshot.data!.restaurants);
    }else if (snapshot.hasError) {  //  error fetch restaurant screen
      return const FetchErrorRestaurants();
    }else { // return Loading restaurant page.
      return const AllRestaurantsMain(true);
    }
  }

  Widget myFavoritesPage(ThemeData theme, AsyncSnapshot<RestaurantQueryResult?> snapshot) {
    if (snapshot.hasRestaurantData()) { // show saved favorite page.
      return MyFavoritesMain(theme,snapshot.data!.restaurants!,myFavoriteKey,key:myFavoriteKey);
    }else if (snapshot.hasError) {  //  error fetch restaurant screen
      return const FetchErrorRestaurants();
    }else { // No favorite page.
      return const NoFavoritesData();
    }
  }

  Tab tabItem(ThemeData theme, String text, int index) {
    return Tab(child: Text(text,
      style: theme.textTheme.button!.copyWith(
          color: _selectedIndex == index ? AppColor.defaultText : AppColor.secondaryText),),);
  }

  @override
  bool get wantKeepAlive => true;
}
