part of 'package.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'RestauranTour',
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All Restaurants'),
              Tab(text: 'My favorites'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AllRestaurantsTab(),
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }
}

class AllRestaurantsTab extends StatelessWidget {
  const AllRestaurantsTab({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.watch<ListRestaurantsProvider>().isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (context.watch<ListRestaurantsProvider>().restaurants != null) {
      return _restaurantsList(context);
    } else {
      return _initialContent(context);
    }
  }

  Widget _restaurantsList(BuildContext context) {
    return ListView.builder(
      itemCount: context.watch<ListRestaurantsProvider>().restaurants!.length,
      itemBuilder: (context, index) {
        final restaurant =
            context.watch<ListRestaurantsProvider>().restaurants![index];
        return RestaurantCardMolecule(restaurant: restaurant);
      },
    );
  }

  Widget _initialContent(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Restaurantour'),
          ElevatedButton(
            child: const Text('Fetch Restaurants'),
            onPressed: () async {
              final yelpRepo = YelpRepository();
              try {
                context.read<ListRestaurantsProvider>().changeIsLoading(true);
                final result = await yelpRepo.getRestaurants();
                if (result != null) {
                  if (context.mounted) {
                    context
                        .read<ListRestaurantsProvider>()
                        .addRestaurants(result.restaurants!);
                    context
                        .read<ListRestaurantsProvider>()
                        .changeIsLoading(false);
                  }
                } else {
                  print('No restaurants fetched');
                }
              } catch (e) {
                print('Failed to fetch restaurants: $e');
              }
            },
          ),
        ],
      ),
    );
  }
}
