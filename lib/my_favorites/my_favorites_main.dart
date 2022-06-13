import 'package:flutter/material.dart';
import 'package:restaurantour/common_widgets/restaurant_row_item.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/my_favorites/no_favorites_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyFavoritesMain extends StatefulWidget {
  final ThemeData theme;
  final List<Restaurant> restaurants;
  final GlobalKey<MyFavoritesMainState> myFavoriteKey;

  const MyFavoritesMain(this.theme, this.restaurants, this.myFavoriteKey, {Key? key}) : super(key: key);

  @override
  State<MyFavoritesMain> createState() => MyFavoritesMainState();
}

class MyFavoritesMainState extends State<MyFavoritesMain> {

  List<Restaurant> favoriteRestaurants = [];

  @override
  void initState() {
    initFavorite();
    super.initState();
  }

  initFavorite() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteList = prefs.getStringList("favoriteList");

    if (favoriteList != null) {
      setState(() {
        for (var element in widget.restaurants) {
          if (favoriteList.contains(element.id)) {
            favoriteRestaurants.add(element);
          }
        }
      });
    }
  }

  refreshPage() {
    favoriteRestaurants.clear();
    initFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return favoriteRestaurants.length > 0 ? ListView.builder(
        padding: const EdgeInsets.fromLTRB(4.0,10,4,10),
        itemCount: favoriteRestaurants.length,
        itemBuilder: (BuildContext context, int index) {
          return RestaurantRowItem(widget.theme,favoriteRestaurants[index],index, widget.myFavoriteKey);
        }
    ) : NoFavoritesData();
  }
}
