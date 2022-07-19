/// Copyright 2022 - Superformula. All rights reserved.
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:restaurantour/providers/restaurantsprovider.dart';
import 'package:restaurantour/widgets/restaurantlistitem.dart';

/// A widget that displays all Favourite Restaurants in a ListView.
/// A widget that does not require mutable state.
/// Show all Favourite Restaurants by calling the Provider
class FavouriteRestaurants extends StatelessWidget {
  const FavouriteRestaurants({
    Key? key,
  }) : super(key: key);

  /// Generate the Widget to show all favourite Restaurants.
  /// Use the Provider to get the Favourite Restaurants from the All Restaurants Map
  /// This Widget build various types of widgets for the UI
  /// Pass the BuildContext as a Parameter to the build method
  /// Get the Favourite Restaurants from the Provider State  - All Favourite Restaurants
  @override
  Widget build(BuildContext context) {
    final resModel = Provider.of<RestaurantsProvider>(context);
    var allrestaurants = resModel.allRestaurantsMap;
    List allFavouriteRestaurants = resModel.allFavouriteRestaurants.entries.map((entry) => (allrestaurants[entry.key])).toList();
    return Center(
      key: const Key("FavouriteRestaurants"),
      child: Column(children: [
        Flexible(
            child: resModel.isFirstLoading
                ? const Center(
                    child: SizedBox(
                        width: 50, height: 50, child: const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black))),
                  )
                : ListView.builder(
                    itemCount: allFavouriteRestaurants.length,
                    itemBuilder: (context, index) {
                      return RestaurantListItem(
                          title: allFavouriteRestaurants[index].name,
                          category: allFavouriteRestaurants[index].displayCategory,
                          image: allFavouriteRestaurants[index].heroImage,
                          isOpen: allFavouriteRestaurants[index].isOpen,
                          price: allFavouriteRestaurants[index].price,
                          rating: allFavouriteRestaurants[index].rating,
                          onTap: () => Navigator.pushNamed(context, '/restaurantdetails', arguments: {"restaurant": allFavouriteRestaurants[index]}));
                    })),
      ]),
    );
  }
}
