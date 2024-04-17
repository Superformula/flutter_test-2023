import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/core/utils/utils.dart';
import 'package:restaurantour/presentation/restaurant_detail/views/views.dart';
import 'package:restaurantour/presentation/restaurant_list/bloc/bloc.dart';
import 'package:restaurantour/presentation/widgets/widgets.dart';

class AllRestaurantsListWidget extends StatefulWidget {
  final RestaurantListBloc restaurantListBloc;
  const AllRestaurantsListWidget({
    super.key,
    required this.restaurantListBloc,
  });

  @override
  State<AllRestaurantsListWidget> createState() =>
      _AllRestaurantsListWidgetState();
}

class _AllRestaurantsListWidgetState extends State<AllRestaurantsListWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantListBloc, FavoriteRestaurantsListState>(
      bloc: widget.restaurantListBloc,
      builder: (context, state) {
        if (state.status == StatusEnum.loading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.black,
            ),
          );
        }
        if (state.status == StatusEnum.success) {
          final restaurants = state.restaurantsList;

          return ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.only(
              left: 12,
              top: 16,
              right: 12,
              bottom: 100,
            ),
            itemCount: 10,
            itemBuilder: (context, index) {
              var restaurant = restaurants?[index];

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => RestaurantDetailPage(
                        restaurantEntity: restaurant,
                      ),
                    ),
                  );
                },
                child: RestaurantInfoCardWidget(
                  restaurant: restaurant,
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 12,
            ),
          );
        }
        if (state.status == StatusEnum.failure) {
          return const CustomErrorWidget();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
