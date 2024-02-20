import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../application/list_restaurants_provider.dart';
import '../atomic/atomic.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'RestauranTour',
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: context.watch<ListRestaurantsProvider>().restaurants != null
          ? ListView.builder(
              itemCount:
                  context.watch<ListRestaurantsProvider>().restaurants!.length,
              itemBuilder: (context, index) {
                final restaurant = context
                    .watch<ListRestaurantsProvider>()
                    .restaurants![index];
                return RestaurantCardMolecule(restaurant: restaurant);
              },
            )
          : const CircularProgressIndicator(),
    );
  }
}
