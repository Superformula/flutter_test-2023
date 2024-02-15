import 'package:flutter/material.dart';
import 'package:restaurantour/common/ui/app_colors.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'RestauranTour',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            tabs: const [
              Tab(text: 'All Restaurants', height: 40,),
              Tab(text: 'My Favorites', height: 40,),
            ],
            indicator: UnderlineTabIndicator(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                width: 2.0,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Theme.of(context).textTheme.bodyMedium?.color,
            unselectedLabelColor: AppColors.kFarquaadGray,
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        body: TabBarView(
          children: [
            _buildAllRestaurantsWidget(),
            _buildMyFavoritesWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildAllRestaurantsWidget() {
    return Text('all restaurants');
  }

  Widget _buildMyFavoritesWidget() {
    return Text('my favorites');
  }
}
