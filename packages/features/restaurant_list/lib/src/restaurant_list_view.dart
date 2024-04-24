import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:restaurant_list/src/restaurant_list_cubit.dart';
import 'package:yelp_repository/yelp_repository.dart';

// TODO: Add localization texts
class RestaurantListView extends StatelessWidget {
  final YelpRepository _yelpRepository;
  const RestaurantListView({
    super.key,
    required YelpRepository yelpRepository,
  }) : _yelpRepository = yelpRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RestaurantListCubit>(
      create: (context) => RestaurantListCubit(_yelpRepository),
      child: const _RestaurantListView(),
    );
  }
}

class _RestaurantListView extends StatefulWidget {
  const _RestaurantListView({super.key});

  @override
  State<_RestaurantListView> createState() => _RestaurantListViewState();
}

class _RestaurantListViewState extends State<_RestaurantListView> {
  final PagingController<int, Restaurant> _pagingController = PagingController(
    firstPageKey: 0,
  );

  @override
  void initState() {
    final cubit = context.read<RestaurantListCubit>();
    _pagingController.addPageRequestListener((_) => cubit.getRestaurants());
    cubit.getRestaurants();
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('RestauranTour'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All restaurants'),
              Tab(text: 'My favorites'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocConsumer<RestaurantListCubit, RestaurantListState>(
              listener: (context, state) {
                if (state.pageStatus.isError) {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('Failed to fetch restaurants'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                } else if (state.pageStatus.isSuccess) {
                  if (state.isLastPage) {
                    _pagingController.appendLastPage(state.restaurants);
                  } else {
                    _pagingController.appendPage(
                      state.restaurants,
                      state.pageIndex,
                    );
                  }
                }
              },
              builder: (context, state) {
                if (state.pageStatus.isInitial) {
                  return const Center(child: CircularProgressIndicator());
                }
                return PagedListView<int, Restaurant>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Restaurant>(
                    itemBuilder: (context, restaurant, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: RestaurantCard(
                        restaurant: restaurant,
                      ),
                    ),
                  ),
                );
              },
            ),
            const Center(child: Text('Favorites')),
          ],
        ),
      ),
    );
  }
}
