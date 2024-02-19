import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../common/restaurant_item.dart';
import '../main.dart';
import '../services/router_service.dart';
import '../utils/strings.dart';
import '../utils/text_styles.dart';

class FavoritesListPage extends StatelessWidget with GetItMixin {
  FavoritesListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: fManager.favList,
      builder: (context, Box box, child) {
        if (fManager.favList.value.isEmpty) {
          return Center(
            child: Text(
              AppStrings.noFavorites,
              style: AppTextStyles.lora18,
              textAlign: TextAlign.center,
            ),
          );
        }

        return ListView.builder(
          itemCount: fManager.favList.value.length,
          itemBuilder: (context, index) {
            final fObjectIndex = box.getAt(index);

            return GestureDetector(
              onTap: () {
                context.router.push(DetailsRoute(item: fObjectIndex));
              },
              child: RestaurantItem(item: fObjectIndex),
            );
          },
        );
      },
    );
  }
}
