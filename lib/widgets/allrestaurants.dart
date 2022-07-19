/// Copyright 2022 - Superformula. All rights reserved.
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:restaurantour/providers/restaurantsprovider.dart';
import 'package:restaurantour/widgets/restaurantlistitem.dart';

/// A widget that displays all Restaurants in a ListView.
/// A widget that does not require mutable state.
/// Show all Restaurants by calling the Provider
class AllRestaurants extends StatelessWidget {
  const AllRestaurants({
    Key? key,
  }) : super(key: key);

  /// Generate the Widget to show all the Restaurants.
  /// Use the Provider to get the Restaurant details from Yelp API
  /// This Widget build various types of widgets for the UI
  /// Pass the BuildContext as a Parameter to the build method
  /// Get the All Restaurants from the Provider State  - All Restaurants
  @override
  Widget build(BuildContext context) {
    final resModel = Provider.of<RestaurantsProvider>(context);
    var allDisplayRestaurants = resModel.allRestaurantsMap;
    var allRestaurantsListCount = resModel.allRestaurantsListCount;
    var listItemCount = (allRestaurantsListCount > allDisplayRestaurants.length) ? allDisplayRestaurants.length + 1 : allDisplayRestaurants.length;
    return Center(
      key: const Key("AllRestaurants"),
      child: Column(children: [
        Flexible(
            child: resModel.isFirstLoading
                ? const Center(
                    child: SizedBox(width: 50, height: 50, child: const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black))),
                  )
                : ListView.builder(
                    itemCount: listItemCount,
                    itemBuilder: (context, index) {
                      if (index == allDisplayRestaurants.length && allDisplayRestaurants.length < allRestaurantsListCount) {
                        return SizedBox(
                            width: 50,
                            height: 60,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(5.0),
                                primary: Colors.black,
                                textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                resModel.loadMoreRestaurants();
                              },
                              child: const Text('Load More'),
                            ));
                      } else {
                        var rKey = allDisplayRestaurants.keys.elementAt(index);
                        return RestaurantListItem(
                          title:allDisplayRestaurants[rKey].name,
                          category: allDisplayRestaurants[rKey].displayCategory,
                          image:allDisplayRestaurants[rKey].heroImage,
                          isOpen:allDisplayRestaurants[rKey].isOpen,
                          price:allDisplayRestaurants[rKey].price,
                          rating:allDisplayRestaurants[rKey].rating,
                          onTap: () =>  Navigator.pushNamed(context, '/restaurantdetails', arguments: {"restaurant": allDisplayRestaurants[rKey]})
                        );
                      }
                    })),
      ]),
    );
  }
}
