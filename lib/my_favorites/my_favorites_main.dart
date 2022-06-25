import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/common_widgets/restaurant_row_item.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/my_favorites/no_favorites_data.dart';
import 'package:restaurantour/repositories/local_db.dart';
import 'package:restaurantour/view_model/restaurant_model.dart';

class MyFavoritesMain extends StatefulWidget {
  const MyFavoritesMain({Key? key}) : super(key: key);

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
    List<String>? favoriteList = await LocalDB.instance.favoriteList;

    RestaurantModel restaurant = context.read<RestaurantModel>();
    if (favoriteList != null) {
      setState(() {
        for (var element in restaurant.restaurants) {
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
    return favoriteRestaurants.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.fromLTRB(4.0, 10, 4, 10),
            itemCount: favoriteRestaurants.length,
            itemBuilder: (BuildContext context, int index) {
              return RestaurantRowItem(
                isLoading: false,
                theme: Theme.of(context),
                restaurant: favoriteRestaurants[index],
                index: index,
              );
            })
        : const NoFavoritesData();
  }
}
