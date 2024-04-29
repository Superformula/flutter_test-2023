import 'package:cached_network_image/cached_network_image.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:restaurant_detail/src/restaurant_detail_cubit.dart';
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
                    children: [
                      SizedBox.square(
                        dimension: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          imageUrl: widget.restaurant.photoUrl ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Row(
                        children: [
                          Text(widget.restaurant.price ?? ''),
                          Text(widget.restaurant.category ?? ''),
                          const Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                widget.restaurant.isOpen ?? false
                                    ? 'Open Now'
                                    : 'Closed',
                              ),
                              Icon(
                                Icons.circle,
                                color: widget.restaurant.isOpen ?? false
                                    ? Colors.green
                                    : Colors.red,
                                size: 8.0,
                              ),
                              const SizedBox(width: 8.0),
                            ],
                          ),
                        ],
                      ),
                      const Divider(),
                      const Text('Address'),
                      Text(widget.restaurant.address ?? ''),
                      const Divider(),
                      const Text('Overall rating'),
                      Row(
                        children: [
                          Text(widget.restaurant.rating?.toString() ?? ''),
                          const Icon(Icons.star),
                        ],
                      ),
                      const Divider(),
                      Text('${_pagingController.value.itemList?.length ?? 0} Reviews'),
                      Text(review.text),
                    ],
                  );
                }
                return Text(review.text);
              },
            ),
          );
        },
      ),
    );
  }
}
