import 'package:flutter/material.dart';
import 'package:restaurantour/app/ui/pages/details_page.dart';

import '../../interactor/models/restaurant.dart';
import '../widgets/restaurant_card.dart';

class RestaurantsPage extends StatefulWidget {
  const RestaurantsPage({Key? key}) : super(key: key);

  @override
  State<RestaurantsPage> createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
  final controller = PageController();
  double currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const tabs = <Widget>[
      Tab(
        text: 'All Restaurants',
      ),
      Tab(
        text: 'My Favorites',
      ),
    ];

    final appbar = AppBar(
      shadowColor: Colors.black.withOpacity(0.2),
      title: const Text('RestauranTour'),
      toolbarHeight: 100,
      bottom: TabBar(
        tabAlignment: TabAlignment.center,
        indicatorColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.black,
        unselectedLabelColor: const Color(0xFF606060),
        labelStyle: theme.textTheme.labelMedium,
        unselectedLabelStyle: theme.textTheme.labelMedium?.copyWith(),
        tabs: tabs,
      ),
    );

    const review1 = Review(
      rating: 4,
      user: User(
        imageUrl: 'https://s3-media4.fl.yelpcdn.com/photo/o36eZXAvfV5y7Ww-LyGkig/o.jpg',
        name: 'Lucas Tinoco',
      ),
    );
    const review2 = Review(
      rating: 4,
      user: User(
        name: 'Gabriel Ribeiro',
      ),
    );
    final restaurant = Restaurant(
      name: 'Gordon Ramsay Hell\'s Kitchen',
      categories: [Category(title: 'New American')],
      price: '\$\$\$',
      rating: 4.4,
      photos: ['https://s3-media2.fl.yelpcdn.com/bphoto/q771KjLzI5y638leJsnJnQ/o.jpg'],
      reviews: [
        review1,
        review2,
      ],
      location: Location(formattedAddress: '3500 Las Vegas Blvd SLas Vegas, NV 89109'),
    );
    final restaurantCard = InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(seconds: 1),
            reverseTransitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (_, __, ___) => DetailsPage(
              restaurant: restaurant,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: RestaurantCard(
          restaurant: restaurant,
        ),
      ),
    );
    var testListView = Center(
      child: ListView(
        children: [
          restaurantCard,
        ],
      ),
    );
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        appBar: appbar,
        body: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: TabBarView(
            children: <Widget>[
              testListView,
              testListView,
            ],
          ),
        ),
      ),
    );
  }
}
