import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/common_widgets/fetch_error_restaurants.dart';
import 'package:restaurantour/common_widgets/restaurant_row_item.dart';
import 'package:restaurantour/view_model/favorite_model.dart';
import 'package:restaurantour/view_model/restaurant_model.dart';

class AllRestaurantsMain extends StatefulWidget {
  const AllRestaurantsMain({Key? key}) : super(key: key);

  @override
  State<AllRestaurantsMain> createState() => _AllRestaurantsMainState();
}

class _AllRestaurantsMainState extends State<AllRestaurantsMain> with AutomaticKeepAliveClientMixin<AllRestaurantsMain> {
  @override
  Widget build(BuildContext context) {
    RestaurantModel restaurant = context.watch<RestaurantModel>();
    FavoriteModel favoriteModel = context.watch<FavoriteModel>();
    if (restaurant.error != null) {
      return FetchErrorRestaurants(restaurant.error!.response as String);
    }
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: ListView.builder(
            key: const Key('AllRestaurantListView'),
            padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
            itemCount: restaurant.listCount,
            itemBuilder: (BuildContext context, int index) {
              if (restaurant.isLoading) {
                return RestaurantRowItem(isLoading: restaurant.isLoading);
              }
              // Restaurant row item with View More button list tile.
              if (index == restaurant.listCount - 1 &&
                  restaurant.listCount < restaurant.restaurants.length) {
                return Column(
                  children: [
                    RestaurantRowItem(
                      isLoading: restaurant.isLoading,
                      favoriteModel: favoriteModel,
                      theme: Theme.of(context),
                      restaurant: restaurant.restaurants[index],
                      index: index,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          onPressed: () {
                            restaurant.increaseListCount();
                          },
                          child: Text(
                            "View More",
                            style: Theme.of(context).textTheme.button,
                          )),
                    ),
                  ],
                );
              }
              return RestaurantRowItem(
                isLoading: restaurant.isLoading,
                favoriteModel: favoriteModel,
                theme: Theme.of(context),
                restaurant: restaurant.restaurants[index],
                index: index,
              );
            }));
  }

  @override
  bool get wantKeepAlive => true;
}
