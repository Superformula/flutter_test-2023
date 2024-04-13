import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurantour/modules/home/data/models/restaurant.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/theme/text_theme.dart';
import 'widgets/circular_progress_widget.dart';

class DetailsRestaurantPage extends StatelessWidget {
  final Restaurant restaurant;
  const DetailsRestaurantPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name ?? ''),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outline_rounded))],
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: restaurant.heroImage,
            height: 361,
            width: double.maxFinite,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, progress) => const CircularProgressWidget(),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(restaurant.displayCategory, style: AppTextStyle.black12w400OpenSans),
                    const Spacer(),
                    Text(
                      restaurant.isOpen ? 'Open Now' : 'Closed',
                      style: AppTextStyle.black12w400OpenSans.copyWith(fontStyle: FontStyle.italic),
                      textAlign: TextAlign.right,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 3),
                      child: CircleAvatar(
                        backgroundColor: restaurant.isOpen ? AppTheme.greenColor : AppTheme.redColor,
                        radius: 4,
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 24), child: Divider()),
                const Text('Address', style: AppTextStyle.black12w400OpenSans),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Text(restaurant.location?.formattedAddress ?? '', style: AppTextStyle.black14w600OpenSans),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 24), child: Divider()),
                const Text('Overall Rating', style: AppTextStyle.black12w400OpenSans),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      Text(
                        '${restaurant.rating ?? 0}',
                        style: AppTextStyle.black18w700.copyWith(fontSize: 28),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Icon(Icons.star, color: AppTheme.yellowColor, size: 16),
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 24), child: Divider()),
                if ((restaurant.reviews?.length ?? 0) > 0) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      (restaurant.reviews?.length ?? 0) == 1 ? '1 Review' : '${restaurant.reviews?.length} Reviews',
                      style: AppTextStyle.black12w400OpenSans,
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: restaurant.reviews!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                    itemBuilder: (context, index) {
                      final review = restaurant.reviews![index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: List.generate(
                              review.rating?.toInt() ?? 0,
                              (index) => const Icon(Icons.star, color: AppTheme.yellowColor, size: 16),
                            ).toList(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Review text goes here. Review text goes here. This is a review. This is a review that is 3 lines long.',
                              style: AppTextStyle.black14w400OpenSans.copyWith(fontSize: 16),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(shape: BoxShape.circle),
                                child: CachedNetworkImage(
                                  imageUrl: review.user?.imageUrl ?? '',
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder: (context, url, progress) => const CircularProgressWidget(),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(review.user?.name ?? '', style: AppTextStyle.black12w400OpenSans),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
