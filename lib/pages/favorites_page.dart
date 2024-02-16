import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:restaurantour/main.dart';

class FavoritesListPage extends StatelessWidget with GetItMixin {
  FavoritesListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Restaurantour'),
          ElevatedButton(
            child: const Text('Fetch Restaurants'),
            onPressed: () async {
              restaurants.getRestaurants();

              debugPrint(restaurants.restaurants.value?.toJson().toString());
            },
          ),
          ListView(
            shrinkWrap: true,
            children: [
              Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  leading: ClipRRect(
                    child: Image.network('https://picsum.photos/250?image=9'),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  title: const Text(
                    'Restaurant name goes here and wrap two lines',
                  ),
                  subtitle: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text('\$\$\$\$ Italian'),
                      ),
                      Row(
                        children: [
                          RatingStars(
                            starCount: 5,
                            starColor: Colors.amber,
                            valueLabelVisibility: false,
                            value: 5,
                          ),
                          Spacer(),
                          Text('Open Now'),
                          SizedBox(width: 8),
                          Icon(
                            Icons.circle_rounded,
                            color: Colors.green,
                            size: 12,
                          ),
                        ],
                      ),
                    ],
                  ),
                  isThreeLine: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
