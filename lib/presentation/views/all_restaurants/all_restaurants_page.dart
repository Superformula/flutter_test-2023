import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/logic/restaurants_bloc/restaurants_bloc.dart';
import 'package:restaurantour/presentation/common/column_loading_placeholder/column_loading_placeholder.dart';
 import 'package:restaurantour/presentation/views/all_restaurants/widgets/list_view.dart';

class AllRestaurantsPage extends StatelessWidget {
  const AllRestaurantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantsBloc, RestaurantsState>(
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
        if (state is RestaurantsLoading) {
          return const ColumnLoadingPlaceholder();
        } else if (state is RestaurantsData) {
          return RestaurantsListView(state.restaurantsList);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
