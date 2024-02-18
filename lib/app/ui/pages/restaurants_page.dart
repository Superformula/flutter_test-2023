import 'package:flutter/material.dart';

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
    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        appBar: appbar,
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Text(
                "It's cloudy here",
                style: theme.textTheme.labelMedium,
              ),
            ),
            const Center(
              child: Text("It's rainy here"),
            ),
          ],
        ),
      ),
    );
  }
}
