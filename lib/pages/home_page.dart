import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:restaurantour/utils/strings.dart';
import 'package:restaurantour/utils/text_styles.dart';

import '../utils/colors.dart';

import 'favorites_page.dart';
import 'restaurants_page.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.white,
          title: Text(
            AppStrings.title,
            style: AppTextStyles.lora18,
          ),
          bottom: TabBar(
            indicatorColor: AppColors.black,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2,
            labelColor: AppColors.black,
            tabAlignment: TabAlignment.center,
            labelStyle: AppTextStyles.openSans14,
            tabs: const [
              Tab(text: AppStrings.tabRestaurants),
              Tab(text: AppStrings.tabFavorites),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RestaurantsListPage(),
            FavoritesListPage(),
          ],
        ),
      ),
    );
  }
}
