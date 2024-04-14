import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/helpers/favorites_helper.dart';
import 'package:restaurantour/main.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/providers/data_provider.dart';
import 'package:restaurantour/widgets/restaurant_card_widget.dart';

class RestaurantsListWidget extends StatefulWidget {
  bool favorites;
  RestaurantsListWidget({this.favorites = false});

  @override
  State<RestaurantsListWidget> createState() => _RestaurantsListWidgetState();
}

class _RestaurantsListWidgetState extends State<RestaurantsListWidget> {
  DataProvider dataProvider = DataProvider();
  bool _isLoading = false;
  List<Restaurant> restaurants = [];
  List<String> favorites = [];

  Future<void> getInitData() async {
    setState(() {
      _isLoading = true;
    });
    favorites = await FavoritesHelpers().getFavorites();
    var result = await dataProvider.getRestaurants();
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    }

    print("Restaurants: ${dataProvider.restaurants}");
    setState(() {
      restaurants = dataProvider.restaurants;
    });

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    dataProvider = Provider.of<DataProvider>(
      context,
      listen: false,
    );
    getInitData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(restaurants);
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 10,
        ),
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator.adaptive()
              : Container(
                  // color: Colors.red,
                  height: size.height,
                  width: size.width,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: ListView.builder(
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) => RestaurantCardWidget(
                      restaurant: restaurants[index],
                      key: Key(
                        restaurants[index].id.toString(),
                      ),
                      favorite: favorites
                          .any((element) => element == restaurants[index].id),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
