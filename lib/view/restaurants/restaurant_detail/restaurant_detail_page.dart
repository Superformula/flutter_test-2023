import 'package:flutter/material.dart';
import 'package:restaurantour/domain/restaurants/entities/restaurant_entity.dart';

class RestaurantDetailPage extends StatelessWidget {
  const RestaurantDetailPage({
    Key? key,
    required this.restaurant,
  }) : super(key: key);
  final RestaurantEntity restaurant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Detail '),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous page
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Display the hero image
            Hero(
              tag: restaurant.id,
              child: Image.network(
                restaurant.heroImage,
                fit: BoxFit.cover,
                height: 300,
                width: double.infinity,
              ),
            ),
            // Display the restaurant name
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                restaurant.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Display the restaurant rating
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Rating: ${restaurant.rating}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            // Display the restaurant price
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Price: ${restaurant.price}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            // Display the restaurant open status
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Open: ${restaurant.isOpen ? 'Yes' : 'No'}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            // Display the restaurant reviews
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: restaurant.reviews
                    .map(
                      (review) => ListTile(
                        // leading: CircleAvatar(
                        //   backgroundImage:
                        //       NetworkImage(review.author.profileImageUrl),
                        // ),
                        title: Text(review.author.name),
                        subtitle: Text(review.comment),
                        trailing: Text('${review.rating}'),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
