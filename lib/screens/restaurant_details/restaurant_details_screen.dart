import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/common/constants.dart';
import 'package:restaurantour/common/extensions.dart';
import 'package:restaurantour/custom_widget/custom_app_bar.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/screens/restaurant_details/restaurant_details_vm.dart';
import 'package:restaurantour/screens/restaurant_details/review_item.dart';

class RestaurantDetails extends StatelessWidget {
  const RestaurantDetails({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  static Future push(BuildContext context, Restaurant restaurant) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestaurantDetails(
          restaurant: restaurant,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RestaurantDetailsVM(),
      child: Consumer<RestaurantDetailsVM>(
        builder: (context, vm, _) {
          vm.init(restaurant);

          return Scaffold(
            appBar: getCustomAppBar(
              context,
              restaurant.name,
              actions: [
                FutureBuilder(
                  future: vm.isFavorite(),
                  builder: (context, snapshot) {
                    return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          snapshot.data == false
                              ? Icons.favorite_border
                              : Icons.favorite,
                          size: 28,
                          color: Colors.black,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        vm.toggleFavorite();
                      },
                    );
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: restaurant.heroImage,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 440,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            Text(
                              restaurant.price ?? kEmptyString,
                              style: context.theme.textTheme.bodyLarge,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              restaurant.displayCategory,
                              style: context.theme.textTheme.bodyLarge,
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  restaurant.isOpen ? "Open Now" : "Closed",
                                  style: context.theme.textTheme.bodyLarge,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.circle,
                              size: 14,
                              color: restaurant.isOpen
                                  ? Colors.green.shade300
                                  : Colors.red,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Divider(
                          color: Colors.grey.shade200,
                          height: 1.5,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          "Address",
                          style: context.theme.textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          restaurant.location?.formattedAddress ?? kEmptyString,
                          style: context.theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Divider(
                          color: Colors.grey.shade200,
                          height: 1.5,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          "Overall Rating",
                          style: context.theme.textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            Text(
                              restaurant.rating?.toString() ?? kEmptyString,
                              style: context.theme.textTheme.headlineLarge
                                  ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 8,
                              ),
                              child: Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Divider(
                          color: Colors.grey.shade200,
                          height: 1.5,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                  if (vm.showReviews)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${vm.restaurant?.reviews?.length} Reviews",
                            style: context.theme.textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: restaurant.reviews?.length ?? kZeroInt,
                            padding: const EdgeInsets.only(
                              top: 16,
                              right: 8,
                              left: 8,
                              bottom: 36,
                            ),
                            itemBuilder: (context, index) {
                              final review = vm.restaurant?.reviews![index];

                              return ReviewItem(
                                rating: review?.rating ?? kZeroInt,
                                userName: review?.user?.name ?? kEmptyString,
                                userImgUrl:
                                    review?.user?.imageUrl ?? kEmptyString,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
