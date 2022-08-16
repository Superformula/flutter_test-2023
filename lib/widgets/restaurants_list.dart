import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superformula_flutter_test/widgets/custom_error_widget.dart';

import '../blocs/restaurant_list/restaurant_list_bloc.dart';
import 'restaurant_tile.dart';

class RestaurantsList extends StatefulWidget {
  const RestaurantsList({Key? key}) : super(key: key);
  @override
  State<RestaurantsList> createState() => _RestaurantsListState();
}

class _RestaurantsListState extends State<RestaurantsList> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<RestaurantListBloc, RestaurantListState>(
      builder: (context, state) {
        if (state is RestaurantListLoaded) {
          return ListView.builder(
            itemCount: state.restaurantResult.restaurants.length,
            padding: EdgeInsets.all(12),
            itemBuilder: (context, index) => RestaurantTile(restaurant: state.restaurantResult.restaurants[index]),
          );
        }
        if (state is RestaurantListError) {
          return CustomErrorWidget();
        }
        return Center(child: CircularProgressIndicator(color: Colors.black));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
