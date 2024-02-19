import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurantour/main.dart';

import '../models/restaurant.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';

class DetailsAppBar extends StatelessWidget
    with GetItMixin
    implements PreferredSizeWidget {
  DetailsAppBar({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Restaurant item;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 1,
      title: Text(
        item.name!,
        style: AppTextStyles.lora18,
      ),
      leading: IconButton(
        onPressed: () {
          context.router.pop();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: AppColors.black,
        ),
      ),
      actions: [
        ValueListenableBuilder(
          valueListenable: fManager.favList,
          builder: (context, Box box, _) {
            final isFavorite = box.get(item.name) != null;

            return IconButton(
              onPressed: () => fManager.setUnsetFavorite(item),
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: AppColors.black,
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
