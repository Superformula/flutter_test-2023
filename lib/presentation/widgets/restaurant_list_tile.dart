import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/bloc/selected_restaurant/selected_restaurant_bloc.dart';
import '../../business_logic/bloc/selected_restaurant/selected_restaurant_event.dart';
import '../../models/restaurant.dart';
import '../router/app_router.dart';
import 'restaurant_is_open_widget.dart';
import 'restaurant_price_and_category_widget.dart';
import 'rating_widget.dart';

class RestaurantListTile extends StatelessWidget {
  const RestaurantListTile({
    required this.restaurant,
    super.key,
  });

  static const restaurantNameStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'Imperial Roman',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    wordSpacing: 1,
    height: 1.5,
  );

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    final image = Padding(
      padding: const EdgeInsets.all(10),
      child: LayoutBuilder(
        builder: (_, constraints) {
          return Hero(
            tag: restaurant.heroImage,
            child: Container(
              width: constraints.maxHeight,
              height: constraints.maxHeight,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: FadeInImage(
                image: NetworkImage(restaurant.heroImage),
                fit: BoxFit.cover,
                placeholder: const AssetImage(
                  'assets/images/restaurant_placeholder.png',
                ),
                imageErrorBuilder: (_, __, ___) =>
                    Container(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );

    final restaurantName = Align(
      alignment: Alignment.topLeft,
      child: Text(
        restaurant.name ?? '',
        style: restaurantNameStyle,
        maxLines: 2,
      ),
    );

    final restaurantPriceAndCategory = Align(
      alignment: const Alignment(-1, 0.45),
      child: RestaurantPriceAndCategoryWidget(restaurant),
    );

    final restaurantEvaluationAndIsOpenOrClosed = Align(
      alignment: Alignment.bottomLeft,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RatingWidget.simple(restaurant.rating),
          RestaurantIsOpenWidget(restaurant),
        ],
      ),
    );

    final restaurantInformation = Padding(
      padding: const EdgeInsets.fromLTRB(0, 9.3, 10, 5.15),
      child: Stack(
        children: [
          restaurantName,
          restaurantPriceAndCategory,
          restaurantEvaluationAndIsOpenOrClosed,
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 9.75,
        vertical: 2,
      ),
      child: GestureDetector(
        onTap: () => onTap(context, restaurant),
        child: Card(
          shadowColor: Colors.grey.shade200,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.75),
          ),
          child: SizedBox(
            height: 110,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                image,
                Expanded(child: restaurantInformation),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTap(
    BuildContext context,
    Restaurant restaurant,
  ) {
    context.read<SelectedRestaurantBloc>().add(SelectedRestaurant(restaurant));
    Navigator.pushNamed(context, AppRouter.restaurantDetailsScreenRouteName);
  }
}
