import 'package:flutter/material.dart';

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
    var testListView = Center(
      child: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: RestaurantCard(
              name: 'Gordon Ramsay Hell\'s Kitchen',
              foodCategories: ['New American', 'Seafood'],
              priceRange: '\$\$\$',
              ratingStars: 4.4,
              isOpenNow: true,
              imageUrl: 'https://s3-media2.fl.yelpcdn.com/bphoto/q771KjLzI5y638leJsnJnQ/o.jpg',
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: RestaurantCard(
              name: 'Gordon Ramsay Hell\'s Kitchen',
              foodCategories: ['New American', 'Seafood'],
              priceRange: '\$\$\$',
              ratingStars: 4.4,
              isOpenNow: false,
              imageUrl: 'https://s3-media2.fl.yelpcdn.com/bphoto/q771KjLzI5y638leJsnJnQ/o.jpg',
            ),
          ),
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
