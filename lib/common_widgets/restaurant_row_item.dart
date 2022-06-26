import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurantour/app_routes.dart';
import 'package:restaurantour/common_widgets/app_place_holder.dart';
import 'package:restaurantour/common_widgets/is_open.dart';
import 'package:restaurantour/common_widgets/rating.dart';
import 'package:restaurantour/detail_view/detail_view_main.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/key_collection.dart';
import 'package:restaurantour/repositories/place_holder_value.dart';
import 'package:restaurantour/theme/app_theme.dart';

/// Common restaurant row Item
/// It uses for all restaurants and my favorites list.

class RestaurantRowItem extends StatelessWidget {
  final bool isLoading;
  final ThemeData? theme;
  final Restaurant? restaurant;
  final int? index;

  const RestaurantRowItem(
      {this.isLoading = false,
      this.theme,
      this.restaurant,
      this.index,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isLoading) {
          Navigator.pushNamed(context, AppRoutes.detailView,
              arguments: DetailViewArgument(restaurant!, index!));
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        child: Container(
          // Row Item decoration.
          decoration: AppTheme.restaurantRowDecoration,
          height: 104,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              restaurantThumbnail(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      restaurantName(),
                      priceAndCategory(),
                      ratingAndIsOpen(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ratingAndIsOpen() {
    return isLoading
        ? Column(
            // Rating and isOpen
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: AppPlaceHolder(
                  height: PlaceHolderValue.priceHeight,
                  width: PlaceHolderValue.priceWidth,
                ),
              ),
              AppPlaceHolder(
                height: PlaceHolderValue.rateHeight,
                width: PlaceHolderValue.rateWidth,
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Rating(restaurant!.rating),
              IsOpen(theme!, restaurant!.hours!.first.isOpenNow ?? false)
            ],
          );
  }

  priceAndCategory() {
    return Padding(
      // Price and Category
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: isLoading
          ? const AppPlaceHolder(height: PlaceHolderValue.normalHeight)
          : priceCategories(),
    );
  }

  priceCategories() => Row(
        children: [
          Text(
            restaurant!.price ?? "",
            style: theme!.textTheme.caption,
          ),
          Text(
            " ${restaurant!.categories?.first.title ?? ""}",
            style: theme!.textTheme.caption,
          ),
        ],
      );

  restaurantName() {
    return isLoading
        ? const AppPlaceHolder(height: PlaceHolderValue.normalHeight)
        : name();
  }

  name() => Expanded(
        // Restaurant Name
        child: Text(
          restaurant!.name ?? "Restaurant Name",
          maxLines: 2,
          style: theme!.textTheme.subtitle1!.copyWith(height: 1.44),
        ),
      );

  restaurantThumbnail() {
    return Padding(
      // Restaurant Image.
      padding: const EdgeInsets.all(8.0),
      child: isLoading
          ? const AppPlaceHolder(
              height: PlaceHolderValue.thumbnailImage,
              width: PlaceHolderValue.thumbnailImage)
          : SizedBox(
              width: 88,
              height: 88,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Hero(
                  tag: "${GlobalKeyName.imageHero}$index",
                  child: restaurant!.photos?.first != null
                      ? CachedNetworkImage(
                          imageUrl: restaurant!.photos!.first,
                          fit: BoxFit.fill,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )
                      : const Icon(Icons.error),
                ),
              ),
            ),
    );
  }
}
