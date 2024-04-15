import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurants_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurants_event.dart';
import 'package:restaurantour/presentation/bloc/restaurants_state.dart';
import 'package:restaurantour/presentation/utils/iterable_extensions.dart';
import 'package:restaurantour/presentation/widgets/category_widget.dart';
import 'package:restaurantour/presentation/widgets/detail_section.dart';
import 'package:restaurantour/presentation/widgets/divider_widget.dart';
import 'package:restaurantour/presentation/widgets/open_status_widget.dart';
import 'package:restaurantour/presentation/widgets/review_widget.dart';
import 'package:restaurantour/presentation/widgets/stars_widget.dart';

class RestaurantDetailPage extends StatelessWidget {
  final String id;

  const RestaurantDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantsBloc, RestaurantsState>(
      builder: (context, state) {
        if (state is RestaurantsLoaded) {
          final restaurant =
              state.restaurants.firstWhereOrNull((r) => r.id == id);

          if (restaurant == null) {
            Navigator.of(context).pop();
            return const SizedBox.shrink();
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(restaurant.name ?? 'Restaurant Details'),
              actions: [
                IconButton(
                  onPressed: () {
                    context
                        .read<RestaurantsBloc>()
                        .add(ToggleFavorite(restaurant.id!));
                  },
                  icon: Icon(
                    restaurant.isFavorite!
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Hero(
                    tag: restaurant.id!,
                    child: Image.network(
                      restaurant.heroImage,
                      height: 375,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CategoryWidget(
                              price: restaurant.price,
                              category: restaurant.displayCategory,
                            ),
                            Expanded(child: Container()),
                            OpenStatusWidget(isOpen: restaurant.isOpen),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const DividerWidget(),
                        DetailSection(
                          title: 'Address',
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              restaurant.location!.formattedAddress!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const DividerWidget(),
                        DetailSection(
                          title: 'Overall Rating',
                          child: StarsWidget.large(rating: restaurant.rating!),
                        ),
                        const DividerWidget(),
                        DetailSection(
                          title: '${restaurant.reviews!.length} Reviews',
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: restaurant.reviews!.length,
                            itemBuilder: (_, i) =>
                                ReviewWidget(review: restaurant.reviews![i]),
                            separatorBuilder: (_, __) => const DividerWidget(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
