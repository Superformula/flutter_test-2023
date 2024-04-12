import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(tabs: [
              Tab(
                text: "All Restaurants",
              ),
              Tab(
                text: "My Favorites",
              ),
            ]),
            title: const Text("RestauranTour"),
            centerTitle: true,
            titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          body: TabBarView(children: [
            Container(),
            Container(),
          ])),
    );
  }
}
