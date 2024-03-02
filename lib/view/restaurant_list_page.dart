import 'package:flutter/material.dart';
import 'package:restaurantour/design_system/restaurant_list_tile.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant List'),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return const RestaurantListTile(
            imageUrl:
                'https:///s3-media4.fl.yelpcdn.com/bphoto/_zXRdYX4r1OBfF86xKMbDw/o.jpg',
            name: 'Sample Restaurant',
            priceRange: '2',
            rating: 4.5,
            isOpen: false,
          );
        },
      ),
    );
  }
}
