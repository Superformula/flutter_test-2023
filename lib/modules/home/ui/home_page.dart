import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:restaurantour/core/theme/app_theme.dart';
import 'package:restaurantour/core/theme/text_theme.dart';
import 'package:restaurantour/core/utils/dependency_injector.dart';
import 'package:restaurantour/modules/home/data/models/restaurant.dart';
import 'package:restaurantour/modules/home/domain/controllers/home_controller.dart';
import 'package:restaurantour/modules/home/ui/widgets/circular_progress_widget.dart';

import 'widgets/card_restaurant_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = locator.get<HomeController>();

  @override
  void initState() {
    controller.loadingInfos();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('RestauranteTour'),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: TabBar(tabs: [Tab(text: 'All Restaurants'), Tab(text: 'My Favorites')]),
          ),
        ),
        body: TabBarView(
          children: [
            Observer(
              builder: (context) {
                if (controller.status.isLoading) return const CircularProgressWidget();

                if (controller.status.isFailure) {
                  // * Error list of restaurants
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const SizedBox(height: 100),
                          Icon(Icons.error_outline, size: 120, color: AppTheme.redColor.withOpacity(0.7)),
                          const SizedBox(height: 16),
                          const Text(
                            'Error returning restaurants,\nplease try again later.',
                            style: AppTextStyle.black14w600,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: controller.loadingInfos,
                            child: const Text('REFRESH', style: AppTextStyle.black16w600),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return CustomScrollView(
                  controller: controller.scrollController,
                  slivers: [
                    // * List Restaurants
                    SliverVisibility(
                      visible: controller.restaurants.isNotEmpty,
                      replacementSliver: SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                const SizedBox(height: 100),
                                Icon(
                                  Icons.subtitles_off_outlined,
                                  size: 150,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(height: 16),
                                const Text('No restaurants in the moment', style: AppTextStyle.black14w600),
                              ],
                            ),
                          ),
                        ),
                      ),
                      sliver: SliverPadding(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                        sliver: SliverList.separated(
                          itemCount: controller.restaurants.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final Restaurant restaurant = controller.restaurants[index];
                            return CardRestaurantWidget(restaurant: restaurant);
                          },
                        ),
                      ),
                    ),
                    // * Loading More
                    SliverVisibility(
                      visible: controller.status.isLoadingMore,
                      sliver: const SliverToBoxAdapter(
                        child: Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressWidget())),
                      ),
                    ),
                  ],
                );
              },
            ),
            Observer(
              builder: (context) {
                if (controller.status.isLoading) return const CircularProgressWidget();

                return Visibility(
                  visible: controller.restaurantsFavorits.isNotEmpty,
                  // * Empty List
                  replacement: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const SizedBox(height: 100),
                          Icon(
                            Icons.subtitles_off_outlined,
                            size: 150,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          const Text('No favorites in the moment', style: AppTextStyle.black14w600),
                        ],
                      ),
                    ),
                  ),

                  // * List Favorites
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    itemCount: controller.restaurantsFavorits.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final Restaurant restaurant = controller.restaurantsFavorits[index];
                      return CardRestaurantWidget(restaurant: restaurant);
                    },
                  ),
                );
                // * Loading More
              },
            ),
          ],
        ),
      ),
    );
  }
}
