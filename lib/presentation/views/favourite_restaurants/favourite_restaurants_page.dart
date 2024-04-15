import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/logic/favourite_restaurants_bloc/favourite_restaurants_bloc.dart';
import 'package:restaurantour/presentation/common/restaurants_list_view/restaurants_list_view.dart';
import 'package:restaurantour/presentation/views/favourite_restaurants/widgets/list_placeholder.dart';

class FavouriteRestaurantsPage extends StatefulWidget {
  const FavouriteRestaurantsPage({Key? key}) : super(key: key);

  @override
  State<FavouriteRestaurantsPage> createState() =>
      _FavouriteRestaurantsPageState();
}

class _FavouriteRestaurantsPageState extends State<FavouriteRestaurantsPage> {
  @override
  void initState() {
    BlocProvider.of<FavouriteRestaurantsBloc>(context)
        .add(LoadRestaurantsStatus());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteRestaurantsBloc, FavouriteRestaurantsState>(
      listener: (context, state) {
        if (state is FavouriteRestaurantsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              elevation: 4,
              margin: const EdgeInsets.only(
                bottom: 0.0,
                right: 24,
                left: 24,
              ),
              content: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is FavouriteRestaurantsData &&
            state.restaurantsList.isNotEmpty) {
          return RestaurantsListView(state.restaurantsList);
        } else {
          return const FavListPlaceholder();
        }
      },
    );
  }
}
