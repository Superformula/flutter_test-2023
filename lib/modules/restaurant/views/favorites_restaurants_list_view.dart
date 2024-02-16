import 'package:flutter/material.dart';
import 'package:restaurantour/common/utils.dart';

import '../../../models/restaurant.dart';
import '../../../widgets/restaurant_card_widget.dart';
import 'restaurant_detail_view.dart';

class FavoritesRestaurantsListView extends StatelessWidget {
  const FavoritesRestaurantsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
      future: Utils.loadFavorites(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          ));
        }

        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var restaurant = snapshot.data![index];
              return InkWell(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RestaurantDetailView(
                        restaurantIndex: index,
                        restaurant: restaurant,
                      ),
                    ),
                  ),
                },
                child: RestaurantCardWidget(
                  restaurantIndex: index,
                  restaurant: restaurant,
                ),
              );
            },
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        return const Center(
          child: Text('Press a button to start fetching data'),
        );
      },
    );
  }
}
