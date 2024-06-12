import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurantour/core/design_system/restaurantour_design_system.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurants_list/bloc/restaurant_list_cubit.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurants_list/widgets/restaurant_item_shimmer_widget.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurants_list/widgets/restaurant_item_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'restaurant_list.dart';
part 'favorite_restaurant_list.dart';

class RestaurantListPage extends StatefulWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  _RestaurantListPageState createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final cubit = GetIt.instance<RestaurantListCubit>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    cubit.fetchRestaurants();
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        if (_tabController.index == 0) {
          cubit.fetchRestaurants();
        } else {
          cubit.fetchFavoriteRestaurants();
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.appTitle,
          style: RestaurantourTextStyles.heading6,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size(0, RestaurantourSizes.size8),
          child: Container(
            alignment: Alignment.center,
            child: TabBar(
              tabAlignment: TabAlignment.center,
              labelColor: Colors.black,
              isScrollable: true,
              controller: _tabController,
              indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: Colors.grey,
              indicator: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: RestaurantourSizes.size1,
                  ),
                ),
              ),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: RestaurantourSizes.size5,
              ),
              tabs: [
                Tab(
                  text: AppLocalizations.of(context)!.allRestaurants,
                ),
                Tab(text: AppLocalizations.of(context)!.myFavorites),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                _RestaurantList(),
                _FavoriteRestaurantList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
