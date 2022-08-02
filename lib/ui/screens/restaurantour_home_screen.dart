import 'package:flutter/material.dart';
import 'package:restaurantour/ui/screens/restaurant_details_screen.dart';
import 'package:restaurantour/ui/widgets/restaurant_list_tile.dart';

import '../../models/restaurant.dart';

const restaurantExample = Restaurant(
  id: 'arandomId',
  name: 'Restaurant Name Goes Here and Wraps 2 Lines',
  hours: [Hours(isOpenNow: true)],
  location: Location(formattedAddress: '123 Main St, New York, NY 10001'),
  photos: [
    'https://images.unsplash.com/photo-1537047902294-62a40c20a6ae?ixlib=rb-'
        '1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto='
        'format&fit=crop&w=2958&q=80',
  ],
  price: '\$\$\$',
  rating: 4.6,
  reviews: [
    Review(
      id: 'reviewId1',
      rating: 4,
      text: "Review text goes here. Review text goes here. "
          "This is a review. This is a review that is 3 lines long.",
      user: User(
        id: 'randomId',
        imageUrl: 'https://images.unsplash.com/photo-1537047902294-62a40c20a6ae?ixlib=rb-'
            '1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto='
            'format&fit=crop&w=2958&q=80',
        name: 'User Name',
      ),
    ),
    Review(
      id: 'reviewId2',
      rating: 3,
      text: "Review text goes here. Review text goes here. "
          "This is a review that is 2 lines long.",
      user: User(
        id: 'randomId',
        imageUrl: 'https://images.unsplash.com/photo-1537047902294-62a40c20a6ae?ixlib=rb-'
            '1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto='
            'format&fit=crop&w=2958&q=80',
        name: 'User Name',
      ),
    ),
    Review(
      id: 'reviewId3',
      rating: 2,
      text: "Review text goes here. Review text goes here. Review text goes here. "
          "This is a review. This is a review. This is a review that is 4 lines long.",
      user: User(
        id: 'randomId',
        imageUrl: 'https://images.unsplash.com/photo-1537047902294-62a40c20a6ae?ixlib=rb-'
            '1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto='
            'format&fit=crop&w=2958&q=80',
        name: 'User Name',
      ),
    ),
  ],
  categories: [Category(title: 'Italian', alias: '')],
);

class RestauranTourHomeScreen extends StatelessWidget {
  const RestauranTourHomeScreen({Key? key}) : super(key: key);

  static const titleStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'VelourRaw',
    fontWeight: FontWeight.w600,
  );

  final bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('RestauranTour', style: titleStyle),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: TabBar(
                indicatorWeight: 2,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                tabs: [
                  Tab(text: 'All Restaurants'),
                  Tab(text: 'My Favorites'),
                ],
              ),
            ),
          ),
        ),
        // Listview with restaurant cards
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return RestaurantListTile(
                    restaurant: restaurantExample,
                    // TODO: Navigate using pushNamed...
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RestaurantDetailsScreen(
                          restaurant: restaurantExample,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
