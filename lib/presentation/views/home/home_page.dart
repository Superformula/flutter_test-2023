import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/logic/restaurants/restaurants_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Restaurantour'),
            BlocConsumer<RestaurantsBloc, RestaurantsState>(
              listener: (context, state) {
                if (state is RestaurantsError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      elevation: 4,
                      margin: const EdgeInsets.only(
                        bottom: 0.0,
                        right: 24,
                        left: 24,
                      ),
                      content: const Text(
                        "Envio concluído",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is RestaurantsData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Loaded ${state.restaurantsList.length} restaurants ",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.grey[350]),
                      ),
                    ],
                  );
                } else if (state is RestaurantsLoading) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Text("Loading")],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            ElevatedButton(
              child: const Text('Fetch Restaurants'),
              onPressed: () async {
                BlocProvider.of<RestaurantsBloc>(context).add(
                  LoadRestaurants(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
