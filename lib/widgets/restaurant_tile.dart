import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/resources/resources_exports.dart';
import 'package:restaurantour/utils/extension_utils.dart';
import 'package:restaurantour/utils/helper_utils.dart';

class RestaurantTile extends StatelessWidget {
  final int index;
  final Restaurant restaurant;
  const RestaurantTile({
    Key? key,
    required this.index,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        horizontal: AppSize.size16,
        vertical: AppSize.size4,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppSize.size8),
        leading: Hero(
          tag: 'Restaurant_${index}_${restaurant.id}',
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: AppSize.size4.w),
                Text(restaurant.price ?? ''),
                SizedBox(width: AppSize.size4.w),
                Text(restaurant.categories.firstOrNull?.title ?? ''),
              ],
            ),
            // SizedBox(height: AppSize.size4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildStarIcons(restaurant.rating),
                statusTag(restaurant.isOpen),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStarIcons(double? rating) {
    final starCount = Utils.roundDoubleToInt(rating);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) => Icon(Icons.star, color: ColorManager.yellow2)),
    );
  }

  Widget statusTag(bool isOpen) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Text(isOpen ? AppStrings.isOpen : AppStrings.isClosed),
      SizedBox(width: AppSize.size4.w),
      Icon(
        Icons.circle,
        size: AppSize.size8,
        color: isOpen ? ColorManager.success : ColorManager.error,
      ),
    ]);
  }
}
