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
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return RestaurantItemWidget(
                  restaurant: Restaurant(
                    id: '1',
                    name: 'Gordon Ramsay Hell\'s Kitchen',
                    price: '\$\$\$',
                    rating: 4.5,
                    photos: [
                      'https://lh5.googleusercontent.com/p/AF1QipMbAecKbQuQpZO8mVoGpsNzV6C7OnjIsOfQOtgt=w114-h114-n-k-no',
                    ],
                    categories: [
                      Category(alias: 'newamerican', title: 'New American'),
                    ],
                    hours: [const Hours(isOpenNow: true)],
                    reviews: [],
                    location:
                        Location(formattedAddress: '123 Example St, City'),
                  ),
                );
              },
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
