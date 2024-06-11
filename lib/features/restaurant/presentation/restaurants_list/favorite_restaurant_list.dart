part of 'restaurant_list_page.dart';

class _FavoriteRestaurantList extends StatelessWidget {
  const _FavoriteRestaurantList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: GetIt.instance<RestaurantListCubit>(),
      child: BlocBuilder<RestaurantListCubit, RestaurantListState>(
        builder: (context, state) {
          if (state is RestaurantListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
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
