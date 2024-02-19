import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

import '../common/custom_loader.dart';
import '../common/restaurant_item.dart';
import '../main.dart';
import '../services/router_service.dart';

class RestaurantsListPage extends StatelessWidget with GetItMixin {
  RestaurantsListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: rManager.getRestaurants(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CustomLoader();
        }

        final rObject = rManager.restaurantList.value?.restaurants;

        return ListView.builder(
          itemCount: rObject?.length,
          itemBuilder: (context, index) {
            final rObjectIndex = rObject?[index];

            if (rObject != null) {
              return GestureDetector(
                onTap: () {
                  context.router.push(DetailsRoute(item: rObjectIndex!));
                },
                child: RestaurantItem(item: rObjectIndex!),
              );
            }

            return null;
          },
        );
      },
    );
  }
}
