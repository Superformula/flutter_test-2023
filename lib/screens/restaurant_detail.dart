import 'package:flutter/material.dart';
import 'package:restaurantour/app_state.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/resources/resources_exports.dart';
import 'package:restaurantour/widgets/price_tag.dart';
import 'package:restaurantour/widgets/review_tile.dart';
import 'package:restaurantour/widgets/star_rating.dart';
import 'package:restaurantour/widgets/status_tag.dart';
import 'package:restaurantour/utils/extension_utils.dart';

class RestaurantDetail extends StatefulWidget {
  const RestaurantDetail({Key? key}) : super(key: key);

  @override
  State<RestaurantDetail> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  Restaurant? restaurant;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ModalRoute.of(context)?.settings.arguments == null) return;
      restaurant = ModalRoute.of(context)?.settings.arguments as Restaurant;

      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(restaurant?.name ?? AppStrings.restaurantDetail),
        actions: [_favoriteButton()],
      ),
      body: (restaurant == null)
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Hero(
                  tag: 'Restaurant_${restaurant?.id}',
                  child: Image.network(
                    restaurant!.heroImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.padding24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: AppPadding.padding24.h),
                      _statusContent(),
                      _setDivider(),

                      // Address content
                      _setSubtitle(AppStrings.address),
                      _customLabel(restaurant?.location?.formattedAddress ?? AppStrings.noData, FontSize.s12.sp),
                      _setDivider(),

                      // rating content
                      _setSubtitle(AppStrings.overallRating),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _customLabel(restaurant?.rating.toString() ?? '0', FontSize.s24.sp),
                          const StarRating(rating: 1),
                        ],
                      ),
                      _setDivider(),

                      // reviews content
                      _setSubtitle(
                        '${restaurant?.reviews?.length ?? 0} ${(restaurant?.reviews?.length == 1) ? AppStrings.review : AppStrings.reviews}',
                      ),
                      ...getReviewList(restaurant?.reviews),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _favoriteButton() {
    final isFavorite = AppState().isFavorite(restaurant);

    return IconButton(
      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
      onPressed: () {
        if (restaurant == null) return;
        if (isFavorite) {
          AppState().removeFavorite(restaurant!);
        } else {
          AppState().addFavorite(restaurant!);
        }
        setState(() {});
      },
    );
  }

  Widget _setDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppPadding.padding24.h),
      child: const Divider(
        thickness: 2,
        height: 1,
      ),
    );
  }

  Widget _setSubtitle(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppPadding.padding16.h),
      child: Text(
        label,
        style: getMediumTextStyle(color: ColorManager.black80, fontSize: FontSize.s12.sp),
      ),
    );
  }

  Widget _customLabel(String label, double fontSize) {
    return Text(
      label,
      style: getBoldTextStyle(color: ColorManager.black80, fontSize: fontSize),
    );
  }

  Widget _statusContent() {
    final style = getMediumTextStyle(fontSize: FontSize.s12.sp, color: ColorManager.black80);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PriceTag(
          price: restaurant?.price,
          category: restaurant?.categories.firstOrNull?.title,
          style: style,
        ),
        StatusTag(
          isOpen: restaurant?.isOpen ?? false,
          style: style,
        ),
      ],
    );
  }

  List<Widget> getReviewList(List<Review>? reviews) {
    if (reviews == null) return [];

    List<Widget> list = [];
    for (int i = 0; i < reviews.length; i++) {
      if (i != 0) list.add(_setDivider());

      list.add(ReviewTile(review: reviews[i]));
    }
    return list;
  }
}
