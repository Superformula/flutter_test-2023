import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superformula_flutter_test/blocs/restaurants/restaurants_bloc.dart';
import 'package:superformula_flutter_test/widgets/general/custom_error_widget.dart';
import 'package:superformula_flutter_test/widgets/general/no_data_found_widget.dart';
import 'package:superformula_flutter_test/widgets/restaurant/restaurant_tile.dart';

class RestaurantsList extends StatefulWidget {
  const RestaurantsList({Key? key}) : super(key: key);
  @override
  State<RestaurantsList> createState() => _RestaurantsListState();
}

class _RestaurantsListState extends State<RestaurantsList> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<RestaurantsBloc, RestaurantsState>(
      builder: (context, state) {
        if (state is RestaurantsLoaded && state.restaurantResult.total != 0) {
          return ListView.builder(
            itemCount: state.restaurantResult.restaurants.length + 1,
            padding: EdgeInsets.all(12),
            itemBuilder: (context, index) {
              if (index >= state.restaurantResult.total) return SizedBox(height: 32);
              if (index == state.restaurantResult.restaurants.length) {
                BlocProvider.of<RestaurantsBloc>(context).add(FetchRestaurants(index));
                return Padding(padding: const EdgeInsets.all(24.0), child: Center(child: CircularProgressIndicator(color: Colors.black)));
              }
              return RestaurantTile(restaurant: state.restaurantResult.restaurants[index]);
            },
          );
        }
        if (state is RestaurantsLoaded && state.restaurantResult.total == 0) {
          return NoDataFoundWidget();
        }
        if (state is RestaurantsError) {
          return CustomErrorWidget();
        }
        return Center(child: CircularProgressIndicator(color: Colors.black));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
