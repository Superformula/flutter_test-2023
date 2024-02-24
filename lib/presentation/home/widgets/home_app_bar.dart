import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/presentation/app/helpers/helpers.dart';
import 'package:restaurantour/presentation/home/state_management/home_tab_controller_cubit/home_tab_controller_cubit.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _HomeAppBarState extends State<HomeAppBar> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.theme;
    final typography = appTheme.typography;
    final colors = appTheme.colors;

    return AppBar(
      title: Text('RestauranTour', style: typography.headingH6),
      backgroundColor: Colors.white,
      shadowColor: colors.black?.withOpacity(0.2),
      bottom: PreferredSize(
        child: BlocBuilder<HomeTabControllerCubit, HomeTabControllerState>(
          builder: (context, state) {
            final isAllRestaurants = state.when(
              allRestaurants: () => true,
              myFavorites: () => false,
            );
            return TabBar(
              controller: _tabController,
              indicatorColor: colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: const EdgeInsets.only(bottom: 8),
              onTap: (value) {
                final cubit = context.read<HomeTabControllerCubit>();
                if (value == 0) {
                  cubit.changeToAllRestaurants();
                } else {
                  cubit.changeToMyFavorites();
                }
              },
              tabs: [
                Text(
                  'All Restaurants',
                  style: typography.button?.copyWith(
                    color: isAllRestaurants ? colors.black : colors.grey,
                  ),
                ),
                Text(
                  'My Favorites',
                  style: typography.button?.copyWith(
                    color: isAllRestaurants ? colors.grey : colors.black,
                  ),
                ),
              ],
            );
          },
        ),
        preferredSize: const Size(double.infinity, 24),
      ),
    );
  }
}
