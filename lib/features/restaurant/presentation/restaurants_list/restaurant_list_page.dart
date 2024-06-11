import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:restaurantour/features/restaurant/domain/models/restaurant.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurants_list/bloc/restaurant_list_cubit.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurants_list/widgets/restaurant_item_widget.dart';

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
        title: const Text('Restaurantour'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size(0, 48.0),
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
                    width: 2,
                  ),
                ),
              ),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              tabs: const [
                Tab(text: "All Restaurants"),
                Tab(text: "My Favorites"),
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
