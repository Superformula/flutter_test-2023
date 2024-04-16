import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/core/utils/utils.dart';
import 'package:restaurantour/presentation/restaurant_detail/cubit/cubit.dart';
import 'package:restaurantour/presentation/restaurant_list/bloc/bloc.dart';
import 'package:restaurantour/presentation/restaurant_list/widgets/widgets.dart';

class RestaurantListView extends StatefulWidget {
  const RestaurantListView({super.key});

  @override
  State<RestaurantListView> createState() => _RestaurantListViewState();
}

class _RestaurantListViewState extends State<RestaurantListView> {
  late RestaurantListBloc _restaurantListBloc;
  late FavoriteRestaurantsCubit _favoriteRestaurantsCubit;

  @override
  void initState() {
    super.initState();
    _restaurantListBloc = BlocProvider.of<RestaurantListBloc>(context);
    _restaurantListBloc.add(GetRestaurantsListEvent());

    _favoriteRestaurantsCubit =
        BlocProvider.of<FavoriteRestaurantsCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: AppColors.white,
          toolbarHeight: 100,
          centerTitle: true,
          elevation: 4,
          title: Text(
            AppWords.restauranTour,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          shadowColor: Colors.grey.withOpacity(0.50),
          bottom: PreferredSize(
            preferredSize: const Size(0, 50),
            child: Column(
              children: [
                TabBar(
                  tabAlignment: TabAlignment.center,
                  labelColor: AppColors.black,
                  isScrollable: true,
                  indicatorColor: AppColors.black,
                  indicatorSize: TabBarIndicatorSize.label,
                  unselectedLabelColor: AppColors.gray,
                  indicator: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.black,
                        width: 2,
                      ),
                    ),
                  ),
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  tabs: [
                    Tab(
                      text: AppWords.allRestaurants,
                    ),
                    Tab(
                      text: AppWords.myFavorites,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            AllRestaurantsListWidget(
              restaurantListBloc: _restaurantListBloc,
            ),
            FavoriteRestaurantsListWidget(
              favoriteRestaurantsCubit: _favoriteRestaurantsCubit,
            ),
          ],
        ),
      ),
    );
  }
}
