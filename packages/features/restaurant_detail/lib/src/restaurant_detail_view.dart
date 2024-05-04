import 'package:cached_network_image/cached_network_image.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:local_storage/local_storage.dart';
import 'package:restaurant_detail/restaurant_detail.dart';
import 'package:restaurant_detail/src/restaurant_detail_cubit.dart';
import 'package:restaurant_detail/src/review_tile.dart';
import 'package:restaurant_detail/src/string_extension.dart';
import 'package:yelp_repository/yelp_repository.dart';

class RestaurantDetailView extends StatelessWidget {
  final YelpRepository _yelpRepository;
  final LocalStorage _localStorage;
  final Restaurant _restaurant;

  const RestaurantDetailView({
    super.key,
    required YelpRepository yelpRepository,
    required LocalStorage localStorage,
    required Restaurant restaurant,
  })  : _yelpRepository = yelpRepository,
        _localStorage = localStorage,
        _restaurant = restaurant;

  @override
  Widget build(BuildContext context) => BlocProvider<RestaurantDetailCubit>(
        create: (context) => RestaurantDetailCubit(
          yelpRepository: _yelpRepository,
          localStorage: _localStorage,
          restaurant: _restaurant,
        ),
        child: _RestaurantDetailView(restaurant: _restaurant),
      );
}

class _RestaurantDetailView extends StatefulWidget {
  final Restaurant restaurant;
  const _RestaurantDetailView({
    super.key,
    required this.restaurant,
  });

  @override
  State<_RestaurantDetailView> createState() => _RestaurantDetailViewState();
}

class _RestaurantDetailViewState extends State<_RestaurantDetailView> {
  final PagingController<int, Review> _pagingController = PagingController(
    firstPageKey: 0,
  );

  @override
  void initState() {
    final cubit = context.read<RestaurantDetailCubit>();
    _pagingController.addPageRequestListener((_) => cubit.getReviews());
    cubit.getReviews();
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RestaurantDetailCubit>();
    final l10n = RestaurantDetailLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.name ?? ''),
        centerTitle: true,
        actions: [
          StreamBuilder<bool>(
              stream: cubit.isFavoriteRestaurant,
              builder: (context, snapshot) {
                final isFavorite = snapshot.hasData && (snapshot.data ?? false);

                return IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  onPressed: snapshot.hasError
                      ? null
                      : isFavorite
                          ? cubit.removeFavoriteRestaurant
                          : cubit.addFavoriteRestaurant,
                );
              }),
        ],
      ),
      body: BlocConsumer<RestaurantDetailCubit, RestaurantDetailState>(
        listener: (context, state) {
          if (state.pageStatus.isError) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(l10n.errorToFetchReviewsMessage),
                  behavior: SnackBarBehavior.floating,
                ),
              );
          } else if (state.pageStatus.isSuccess) {
            if (state.isLastPage) {
              _pagingController.appendLastPage(state.reviews);
            } else {
              _pagingController.appendPage(
                state.reviews,
                state.pageIndex,
              );
            }
          }
        },
        builder: (context, state) {
          if (state.pageStatus.isInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          return PagedListView<int, Review>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Review>(
              itemBuilder: (context, review, index) {
                if (index == 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildImage(),
                      const SizedBox(height: 24.0),
                      ...[
                        _buildCostCategoryAndAvailability(),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.0),
                          child: Divider(),
                        ),
                        ..._buildAddress(l10n),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.0),
                          child: Divider(),
                        ),
                        ..._buildOverallRating(l10n),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.0),
                          child: Divider(),
                        ),
                        Text(
                          l10n.reviewsQuantity.format(
                            [
                              '${_pagingController.value.itemList?.length ?? 0}'
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ReviewTile(review: review),
                        ),
                      ]
                          .map(
                            (widget) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              child: widget,
                            ),
                          )
                          .toList(),
                    ],
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ReviewTile(review: review),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Row _buildCostCategoryAndAvailability() {
    return Row(
      children: [
        Text(widget.restaurant.price ?? ''),
        Text(widget.restaurant.category ?? ''),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: AvailabilityIndicator(
            isOpen: widget.restaurant.isOpen ?? false,
          ),
        )
      ],
    );
  }

  SizedBox _buildImage() => SizedBox.square(
        dimension: MediaQuery.of(context).size.width,
        child: Hero(
          tag: 'restaurant_${widget.restaurant.id}',
          child: CachedNetworkImage(
            imageUrl: widget.restaurant.photoUrl ?? '',
            errorWidget: (_, __, ___) => const Icon(Icons.restaurant),
            fit: BoxFit.cover,
          ),
        ),
      );

  List<Widget> _buildAddress(RestaurantDetailLocalizations l10n) => [
        Text(l10n.addressSectionTitle),
        const SizedBox(height: 24.0),
        Text(widget.restaurant.address ?? '')
      ];

  List<Widget> _buildOverallRating(RestaurantDetailLocalizations l10n) => [
        Text(l10n.ratingSectionTitle),
        const SizedBox(height: 16.0),
        Row(
          children: [
            Text(widget.restaurant.rating?.toStringAsFixed(2) ?? ''),
            const RatingStar(),
          ],
        ),
      ];
}
