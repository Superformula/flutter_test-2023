import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:local_storage/local_storage.dart';
import 'package:restaurant_list/restaurant_list.dart';
import 'package:restaurant_list/src/assets.dart';
import 'package:restaurant_list/src/restaurant_list_cubit.dart';
import 'package:yelp_repository/yelp_repository.dart';

const restaurantListAllRestaurantsTabKey = Key(
  'restaurantListAllRestaurantsTabKey',
);
const restaurantListFavoritesRestaurantsTabKey = Key(
  'restaurantListFavoritesRestaurantsTabKey',
);
const emptyFavoritesImageKey = Key('emptyFavoritesImageKey');

class RestaurantListView extends StatelessWidget {
  final YelpRepository _yelpRepository;
  final LocalStorage _localStorage;
  final Function(Restaurant) onRestaurantTapped;

  const RestaurantListView({
    super.key,
    required YelpRepository yelpRepository,
    required LocalStorage localStorage,
    required this.onRestaurantTapped,
  })  : _localStorage = localStorage,
        _yelpRepository = yelpRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RestaurantListCubit>(
      create: (context) => RestaurantListCubit(
        yelpRepository: _yelpRepository,
        localStorage: _localStorage,
      ),
      child: _RestaurantListView(onRestaurantTapped: onRestaurantTapped),
    );
  }
}

class _RestaurantListView extends StatefulWidget {
  final Function(Restaurant) onRestaurantTapped;

  const _RestaurantListView({super.key, required this.onRestaurantTapped});

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
    final l10n = RestaurantListLocalizations.of(context);
    final theme = Theme.of(context);

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            l10n.appBarTitle,
            style: theme.textTheme.headline6,
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                key: restaurantListAllRestaurantsTabKey,
                text: l10n.allRestaurantsTabTitle,
              ),
              Tab(
                key: restaurantListFavoritesRestaurantsTabKey,
                text: l10n.favoritesTabTitle,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildAllRestaurants(l10n),
            _buildFavoriteRestaurants(l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteRestaurants(RestaurantListLocalizations l10n) =>
      BlocBuilder<RestaurantListCubit, RestaurantListState>(
        builder: (context, state) {
          final cubit = context.read<RestaurantListCubit>();
          return StreamBuilder<List<Restaurant>>(
            stream: cubit.favoriteRestaurants,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(l10n.errorToFetchFavoritesErrorMessage),
                );
              }

              if (snapshot.hasData) {
                final restaurants = snapshot.data ?? [];
                if (restaurants.isEmpty) {
                  return Column(
                    children: [
                      const Spacer(),
                      SizedBox.square(
                        key: emptyFavoritesImageKey,
                        dimension: 200,
                        child: SvgPicture.asset(
                          Assets.emptyFavoritesPath,
                        ),
                      ),
                      Text(l10n.emptyFavoritesMessage),
                      const Spacer(),
                    ],
                  );
                } else {
                  return ListView.builder(
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = restaurants[index];
                      return _buildRestaurantCard(restaurant);
                    },
                  );
                }
              }

              return const Center(child: CircularProgressIndicator());
            },
          );
        },
      );

  Widget _buildAllRestaurants(RestaurantListLocalizations l10n) =>
      BlocConsumer<RestaurantListCubit, RestaurantListState>(
        listener: (context, state) {
          if (state.pageStatus.isSuccess) {
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

          if (state.pageStatus.isError) {
            return Column(
              children: [
                const Spacer(),
                SizedBox.square(
                  dimension: 200,
                  child: SvgPicture.asset(
                    Assets.errorToFetchRestaurantsPath,
                  ),
                ),
                Text(l10n.errorToFetchAllRestaurantsErrorMessage),
                const Spacer(),
              ],
            );
          }

          return PagedListView<int, Restaurant>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Restaurant>(
              itemBuilder: (context, restaurant, index) =>
                  _buildRestaurantCard(restaurant),
            ),
          );
        },
      );

  Padding _buildRestaurantCard(Restaurant restaurant) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: RestaurantCard(
          restaurant: restaurant,
          onRestaurantTapped: widget.onRestaurantTapped,
        ),
      );
}
