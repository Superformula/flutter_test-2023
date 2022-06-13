
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:restaurantour/common_widgets/restaurant_row_item.dart';
import 'package:restaurantour/common_widgets/restaurant_row_item_place_holder.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/my_favorites/my_favorites_main.dart';

class AllRestaurantsMain extends StatefulWidget {
  final bool isLoading;
  final ThemeData? theme;
  final List<Restaurant>? restaurants;
  final GlobalKey<MyFavoritesMainState> myFavoriteKey;

  AllRestaurantsMain(this.isLoading, this.myFavoriteKey, [this.theme,
      this.restaurants]); // const RestaurantList({Key? key}) : super(key: key);

  @override
  State<AllRestaurantsMain> createState() => _AllRestaurantsMainState();
}

class _AllRestaurantsMainState extends State<AllRestaurantsMain> {

  int listCount = 7;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(4.0,10,4,10),
        itemCount: listCount,
        itemBuilder: (BuildContext context, int index) {
          if (widget.isLoading) return RestaurantRowItemPlaceHolder();
          if (index == listCount - 1 && listCount < widget.restaurants!.length) {
            return Column(
              children: [
                RestaurantRowItem(widget.theme!,widget.restaurants![index],index, widget.myFavoriteKey),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        listCount = min(listCount + 7, widget.restaurants!.length);
                      });
                    },
                    child: Text("View More",style: widget.theme!.textTheme.button,)),
                ),
              ],
            );
          }
          return RestaurantRowItem(widget.theme!,widget.restaurants![index],index, widget.myFavoriteKey);
        }
      )
    );}
}
