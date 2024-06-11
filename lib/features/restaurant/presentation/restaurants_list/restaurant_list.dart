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
            return const Center(
              child: CircularProgressIndicator(),
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
                      'https://s3-media2.fl.yelpcdn.com/bphoto/q771KjLzI5y638leJsnJnQ/o.jpg',
                    ],
                    categories: [
                      Category(alias: 'newamerican', title: 'New American'),
                    ],
                    hours: [const Hours(isOpenNow: true)],
                    reviews: [
                      const Review(
                        id: '1',
                        rating: 5,
                        user: User(
                          id: '1',
                          imageUrl:
                              'https://s3-media2.fl.yelpcdn.com/photo/1.jpg',
                          name: 'John Doe',
                        ),
                      ),
                    ],
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
