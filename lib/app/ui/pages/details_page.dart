import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../interactor/models/restaurant.dart';
import '../helpers/generate_random_review.dart';
import '../widgets/status_row.dart';

class DetailsPage extends StatelessWidget {
  final Restaurant restaurant;

  const DetailsPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final restaurantDescription = '${restaurant.price} ${restaurant.displayCategory}';

    final appBar = AppBar(
      title: Text(restaurant.name ?? ''),
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          if (Navigator.of(context).canPop()) Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_outlined),
        color: Colors.black,
        iconSize: 24,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite_border_outlined,
            color: Colors.black,
            size: 24,
          ),
        ),
      ],
    );

    final heroImage = Hero(
      tag: restaurant.heroImage,
      child: CachedNetworkImage(
        imageUrl: restaurant.heroImage,
        imageBuilder: (context, imageProvider) => Container(
          width: MediaQuery.of(context).size.width,
          height: 360,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );

    final summaryRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Hero(
          tag: 'restaurantDescription$restaurantDescription${restaurant.name}',
          child: Text(restaurantDescription, style: theme.textTheme.labelSmall),
        ),
        Hero(
          tag: 'isOpenNow${restaurant.isOpen}${restaurant.name}',
          child: StatusRow(isOpenNow: restaurant.isOpen),
        ),
      ],
    );

    const customDivider = Divider(
      height: 1,
      color: Color(0xFFAAAAAA),
    );

    final summarySection = Column(
      children: [
        const SizedBox(height: 24),
        summaryRow,
        const SizedBox(height: 24),
        customDivider,
      ],
    );

    final addressSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text('Address', style: theme.textTheme.labelSmall),
        const SizedBox(height: 24),
        Text(
          restaurant.location?.formattedAddress ?? 'Address not found',
          style: theme.textTheme.labelMedium,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 24),
        customDivider,
      ],
    );

    final overallRatingSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text('Overall Rating', style: theme.textTheme.labelSmall),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(restaurant.rating.toString(), style: theme.textTheme.labelLarge),
            const SizedBox(width: 2),
            const Icon(
              Icons.star,
              color: Color(0xFFFFB800),
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            heroImage,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  summarySection,
                  addressSection,
                  overallRatingSection,
                  if (restaurant.reviews != null && restaurant.reviews!.isNotEmpty) ...[
                    _buildReviewList(restaurant.reviews!, theme),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Column _buildReviewList(List<Review> reviews, ThemeData theme) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '${reviews.length} Reviews',
        style: theme.textTheme.labelSmall,
      ),
      Column(
        children: reviews.map((item) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              _buildReviewCard(item, theme),
              const SizedBox(height: 16),
            ],
          );
        }).toList(),
      ),
    ],
  );
}

Widget _buildReviewCard(Review review, ThemeData theme) {
  final ratingBarIndicator = RatingBarIndicator(
    rating: review.rating?.toDouble() ?? 0,
    itemBuilder: (context, index) => const Icon(
      Icons.star,
      color: Color(0xFFFFB800),
    ),
    itemCount: 5,
    itemSize: 20.0,
    direction: Axis.horizontal,
    unratedColor: Colors.transparent,
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ratingBarIndicator,
      const SizedBox(height: 8),
      Text(review.text ?? generateRandomReview(), style: theme.textTheme.bodyLarge),
      const SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.black12,
            child: review.user?.imageUrl == null
                ? const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 40,
                  )
                : CachedNetworkImage(
                    imageUrl: review.user!.imageUrl!,
                    imageBuilder: (context, imageProvider) => ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
          ),
          const SizedBox(width: 8),
          Text(review.user?.name ?? 'User', style: theme.textTheme.labelSmall),
        ],
      ),
    ],
  );
}
