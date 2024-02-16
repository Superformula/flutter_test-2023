import 'package:flutter/material.dart';
import 'package:restaurantour/common/ui/app_colors.dart';
import 'package:restaurantour/common/ui/themes.dart';
import 'package:restaurantour/features/restaurant/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/features/restaurant/presentation/widgets/restaurant_status_widget.dart';
import 'package:restaurantour/features/restaurant/presentation/widgets/star_rating_widget.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  const RestaurantDetailsScreen({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final RestaurantEntity restaurant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Themes.iconTheme,
        title: Center(
          child: Text(
            restaurant.name ?? "",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.favorite,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              restaurant.heroImage,
              fit: BoxFit.cover,
              height: 362,
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${restaurant.price ?? ""} ${restaurant.displayCategory}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      RestaurantStatusWidget(isOpen: restaurant.isOpen),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Divider(
                      color: AppColors.kScreechingWhite,
                      thickness: 2,
                    ),
                  ),
                  Text(
                    restaurant.location?.formattedAddress ?? "",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Divider(
                      color: AppColors.kScreechingWhite,
                      thickness: 2,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Overall Rating',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${restaurant.rating ?? '-'}',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Icon(
                              Icons.star,
                              size: 12,
                              color: AppColors.kDandyDaffodilYellow,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Divider(
                      color: AppColors.kScreechingWhite,
                      thickness: 2,
                    ),
                  ),
                  Text(
                    '${restaurant.reviews?.length ?? '0'} Reviews',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => _buildReviewItemWidget(
                            context,
                            index,
                          ),
                      separatorBuilder: (_, __) => const Divider(
                            color: AppColors.kScreechingWhite,
                            thickness: 2,
                          ),
                      itemCount: restaurant.reviews?.length ?? 0,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewItemWidget(
    BuildContext context,
    int index,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StarRatingWidget(rating: restaurant.rating),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              restaurant.reviews?[index].text ?? "",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Row(
            children: [
              if (restaurant.reviews?[index].user?.imageUrl != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                        restaurant.reviews![index].user!.imageUrl!,),
                  ),
                ),
              Text(
                restaurant.reviews?[index].user?.name ?? "",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
