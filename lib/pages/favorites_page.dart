import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import '../models/restaurant.dart';
import '../repositories/yelp_repository.dart';

class FavoritesListPage extends StatelessWidget {
  const FavoritesListPage({
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
              _fetchRestaurantData();
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

Future<RestaurantQueryResult?> _fetchRestaurantData() async {
  final yelpRepo = YelpRepository();

  try {
    final result = await yelpRepo.getRestaurants();
    if (result != null) {
      print(
        'Fetched ${result.restaurants!.length} restaurants',
      );

      return result;
    } else {
      print('No restaurants fetched');

      return null;
    }
  } catch (e) {
    print('Failed to fetch restaurants: $e');

    return null;
  }
}
