import 'package:flutter/material.dart';
import 'package:restaurantour/all_restaurants/all_restaurants_main.dart';
import 'package:restaurantour/common_widgets/fetch_error_restaurants.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/my_favorites/my_favorites_main.dart';
import 'package:restaurantour/my_favorites/no_favorites_data.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';
import 'package:restaurantour/theme/app_color.dart';

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
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // TODO: Need to check the size again.
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.05),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.14),
            child: TabBar(
              controller: _controller,
              tabs: [
                tabItem(theme,"All Restaurants",0),
                tabItem(theme,"My Favorites",1)
              ],
            ),
          ),
        ),
        title: Text('RestauranTour', style: theme.textTheme.headline6,),
        toolbarHeight: size.height * 0.082,
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
    if (isHasRestaurantData(snapshot)) {
      return AllRestaurantsMain(false,myFavoriteKey,theme,snapshot.data!.restaurants);
    }else if (snapshot.hasError) {
      return FetchErrorRestaurants();
    }else {
      return AllRestaurantsMain(true,myFavoriteKey);
    }
  }

  Widget myFavoritesPage(ThemeData theme, AsyncSnapshot<RestaurantQueryResult?> snapshot) {

    if (isHasRestaurantData(snapshot)) {
      return MyFavoritesMain(theme,snapshot.data!.restaurants!,myFavoriteKey,key:myFavoriteKey);
    }else if (snapshot.hasError) {
      return FetchErrorRestaurants();
    }else {
      return NoFavoritesData();
    }
  }

  bool isHasRestaurantData(AsyncSnapshot<RestaurantQueryResult?> snapshot) {
    if (snapshot.hasData) {
      List<Restaurant>? restaurants = snapshot.data!.restaurants;
      if (restaurants != null) {
        if (restaurants.isNotEmpty) {
          return true;
        }
      }
    }
    return false;
  }

  Tab tabItem(ThemeData theme, String text, int index) {
    return Tab(child: Text(text,
      style: theme.textTheme.button!.copyWith(
          color: _selectedIndex == index ? AppColor.defaultText : AppColor.secondaryText),),);
  }

  @override
  bool get wantKeepAlive => true;
}
