import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/resources/resources_exports.dart';
import 'package:restaurantour/resources/routes_manager.dart';
import 'package:restaurantour/utils/extension_utils.dart';
import 'package:restaurantour/widgets/price_tag.dart';
import 'package:restaurantour/widgets/star_rating.dart';
import 'package:restaurantour/widgets/status_tag.dart';

class RestaurantTile extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantTile({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  void _goToPage(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.restaurantDetailRoute,
      arguments: restaurant,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        horizontal: AppSize.size16,
        vertical: AppSize.size4,
      ),
      child: GestureDetector(
        onTap: () => _goToPage(context),
        child: ListTile(
          contentPadding: const EdgeInsets.all(AppSize.size8),
          leading: Hero(
            tag: 'Restaurant_${restaurant.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.size8),
              child: Image.network(
                restaurant.heroImage,
                width: AppSize.size80,
                height: AppSize.size80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            restaurant.name ?? AppStrings.noData,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: getSemiBoldTextStyle(color: ColorManager.black80, fontSize: FontSize.s16.sp),
          ),
          subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: AppPadding.padding8.h),
              PriceTag(price: restaurant.price, category: restaurant.categories.firstOrNull?.title),
              SizedBox(height: AppSize.size4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StarRating(rating: restaurant.rating),
                  StatusTag(isOpen: restaurant.isOpen),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
