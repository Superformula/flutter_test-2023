import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:restaurantour/l10n/l10n.dart';
import 'package:restaurantour/restaurant_detail/cubit/restaurant_detail_cubit.dart';
import 'package:restaurantour_ui/restaurantour_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

class RestaurantDetailInformation extends StatelessWidget {
  const RestaurantDetailInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restaurant = context.select<RestaurantDetailCubit, Restaurant>(
      (cubit) => cubit.state.restaurant,
    );
    return SliverPadding(
      padding: const EdgeInsets.all(RestaurantourPaddingValues.xl),
      sliver: MultiSliver(
        children: [
          _CategoryAttentionStatus(
            category: restaurant.category ?? '',
            isOpen: restaurant.isOpenNow ?? false,
            price: restaurant.price ?? '',
          ),
          _Address(text: restaurant.address),
          _OverallRating(rating: restaurant.rating),
          _Reviews(reviews: restaurant.reviews),
        ],
      ),
    );
  }
}

class _Address extends StatelessWidget {
  const _Address({Key? key, required this.text}) : super(key: key);
  final String? text;
  @override
  Widget build(BuildContext context) {
    const addressWidth = 121.0;
    final l10n = context.l10n;
    if (text == null) return const SliverToBoxAdapter(child: SizedBox());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: RestaurantourPaddingValues.xl,
        ),
        Text(
          l10n.restaurantDetailsAddressText,
          style: Theme.of(context).textTheme.caption,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: RestaurantourPaddingValues.xl,
          ),
          child: SizedBox(
            width: addressWidth,
            child: Text(
              text!,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const _DividerLine(),
      ],
    );
  }
}

class _OverallRating extends StatelessWidget {
  const _OverallRating({Key? key, required this.rating}) : super(key: key);
  final double? rating;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    const iconBottomPadding = 7.0;
    if (rating == null) return const SliverToBoxAdapter(child: SizedBox());
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: RestaurantourPaddingValues.xl,
          ),
          Text(
            l10n.restaurantDetailsOverallRaitingText,
            style: Theme.of(context).textTheme.caption,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: RestaurantourPaddingValues.l,
              bottom: RestaurantourPaddingValues.xl,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  rating.toString(),
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(
                  width: RestaurantourPaddingValues.extraSmall,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: iconBottomPadding),
                  child: Icon(
                    Icons.star,
                    color: RestaurantourColors.star,
                    size: 12,
                  ),
                )
              ],
            ),
          ),
          const _DividerLine()
        ],
      ),
    );
  }
}

class _Reviews extends StatelessWidget {
  const _Reviews({Key? key, required this.reviews}) : super(key: key);
  final List<Review>? reviews;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (reviews?.isEmpty ?? false) return const SizedBox();
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(
              top: RestaurantourPaddingValues.xl,
            ),
            child: Text(
              '${reviews!.length} ${l10n.restaurantDetailsReviewText}',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) {
              return _Review(
                review: reviews![index],
                showDividerLine: reviews!.length - 1 != index,
              );
            },
            childCount: reviews!.length,
          ),
        ),
      ],
    );
  }
}

class _Review extends StatelessWidget {
  const _Review({Key? key, required this.review, this.showDividerLine = true})
      : super(key: key);
  final Review review;
  final bool showDividerLine;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    const userImageSize = 40.0;
    return Column(
      children: [
        const SizedBox(
          height: RestaurantourPaddingValues.l,
        ),
        Rating(rating: review.rating ?? 0),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: RestaurantourPaddingValues.medium,
          ),
          child: Text(
            review.text ?? l10n.noReviewDescriptionText,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Row(
          children: [
            ClipOval(
              child: SizedBox(
                width: userImageSize,
                height: userImageSize,
                child: review.user?.imageUrl != null
                    ? CachedNetworkImage(imageUrl: review.user!.imageUrl!)
                    : const Icon(Icons.person),
              ),
            ),
            const SizedBox(
              width: RestaurantourPaddingValues.medium,
            ),
            Text(
              review.user?.name ?? '',
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
        const SizedBox(
          height: RestaurantourPaddingValues.l,
        ),
        if (showDividerLine) const _DividerLine()
      ],
    );
  }
}

class _CategoryAttentionStatus extends StatelessWidget {
  const _CategoryAttentionStatus({
    Key? key,
    required this.category,
    required this.isOpen,
    required this.price,
  }) : super(key: key);
  final String? category;
  final String? price;
  final bool isOpen;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: RestaurantourPaddingValues.xl),
          child: Row(
            children: [
              Text(
                '$price $category',
                style: Theme.of(context).textTheme.caption,
              ),
              const Spacer(),
              AttentionStatus(
                text: isOpen
                    ? l10n.attentionStatusOpen
                    : l10n.attentionStatusClosed,
                iconColor: isOpen
                    ? RestaurantourColors.open
                    : RestaurantourColors.closed,
              ),
            ],
          ),
        ),
        const _DividerLine(),
      ],
    );
  }
}

class _DividerLine extends StatelessWidget {
  const _DividerLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: RestaurantourColors.dividerLine,
    );
  }
}
