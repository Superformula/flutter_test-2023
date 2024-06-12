part of 'restaurant_list_page.dart';

class _RestaurantList extends StatelessWidget {
  const _RestaurantList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: GetIt.instance<RestaurantListCubit>(),
      child: BlocBuilder<RestaurantListCubit, RestaurantListState>(
        builder: (context, state) {
          if (state is RestaurantListLoading) {
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const ShimmerRestaurantItemWidget();
              },
            );
          }

          if (state is RestaurantListLoaded) {
            return ListView.builder(
              itemCount: state.restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = state.restaurants[index];
                return RestaurantItemWidget(
                  restaurant: restaurant,
                );
              },
            );
          }

          if (state is FavoriteRestaurantsLoaded) {
            return ListView.builder(
              itemCount: state.restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = state.restaurants[index];
                return RestaurantItemWidget(
                  restaurant: restaurant,
                );
              },
            );
          }

          if (state is RestaurantListError) {
            return Center(
              child: Text(
                state.message,
                style: RestaurantourTextStyles.caption.copyWith(
                  color: Colors.red,
                ),
              ),
            );
          }

          return const Center(
            child: Text('Restaurantour'),
          );
        },
      ),
    );
  }
}
