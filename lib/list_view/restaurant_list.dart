
import 'package:flutter/material.dart';
import 'package:restaurantour/list_view/restaurant_row_item.dart';
import 'package:restaurantour/list_view/restaurant_row_item_loading.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/yelp_repository.dart';

class RestaurantList extends StatefulWidget {
  final ThemeData theme;

  RestaurantList(
      this.theme); // const RestaurantList({Key? key}) : super(key: key);

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: FutureBuilder<RestaurantQueryResult?>(
        future: YelpRepository().getRestaurants(),
        builder: (BuildContext context, AsyncSnapshot<RestaurantQueryResult?> snapshot) {
          if (snapshot.hasData) {
            return ListView(
                padding: const EdgeInsets.fromLTRB(4.0,10,4,10),
                children: ["1","2","3","4","5","6","7"].map((e) {
                  return RestaurantRowItem(widget.theme);
                }).toList()
            );
          } else if (snapshot.hasError) {
            return snapshotErrorWidget();
          } else {
            return ListView(
                padding: const EdgeInsets.fromLTRB(4.0,10,4,10),
                children: ["1","2","3","4","5","6","7"].map((e) {
                  return RestaurantRowItemLoading();
                }).toList()
            );
          }
        },
      ),
    );
  }

  snapshotErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('Error: Please check your internet connection.'),
          )
        ],
      ),
    );
  }
}
