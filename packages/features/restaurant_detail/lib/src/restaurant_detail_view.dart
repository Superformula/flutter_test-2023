import 'package:cached_network_image/cached_network_image.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:restaurant_detail/src/restaurant_detail_cubit.dart';
import 'package:restaurant_detail/src/review_tile.dart';
import 'package:yelp_repository/yelp_repository.dart';

class RestaurantDetailView extends StatelessWidget {
  final YelpRepository _yelpRepository;
  final Restaurant _restaurant;

  // TODO: Add localization texts
  const RestaurantDetailView({
    super.key,
    required YelpRepository yelpRepository,
    required Restaurant restaurant,
  })  : _yelpRepository = yelpRepository,
        _restaurant = restaurant;

  @override
  Widget build(BuildContext context) => BlocProvider<RestaurantDetailCubit>(
        create: (context) => RestaurantDetailCubit(
          yelpRepository: _yelpRepository,
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.name ?? ''),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => print('Favorite button pressed'),
          ),
        ],
      ),
      body: BlocConsumer<RestaurantDetailCubit, RestaurantDetailState>(
        listener: (context, state) {
          if (state.pageStatus.isError) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Failed to fetch reviews'),
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
                        ..._buildAddress(),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.0),
                          child: Divider(),
                        ),
                        ..._buildOverallRating(),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.0),
                          child: Divider(),
                        ),
                        Text(
                          '${_pagingController.value.itemList?.length ?? 0} Reviews',
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

  List<Widget> _buildAddress() => [
        const Text('Address'),
        const SizedBox(height: 24.0),
        Text(widget.restaurant.address ?? '')
      ];

  List<Widget> _buildOverallRating() => [
        const Text('Overall rating'),
        const SizedBox(height: 16.0),
        Row(
          children: [
            Text(widget.restaurant.rating?.toString() ?? ''),
            const RatingStar(),
          ],
        ),
      ];
}
