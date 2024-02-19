import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/presentation/bloc/restaurant_details_bloc/restaurant_details_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurant_details_bloc/restaurant_details_event.dart';
import 'package:restaurantour/presentation/bloc/restaurant_details_bloc/restaurant_details_state.dart';
import 'package:restaurantour/presentation/pages/widgets/custom_progress_indicator.dart';
import 'package:restaurantour/presentation/pages/widgets/is_open_widget.dart';
import 'package:restaurantour/presentation/pages/widgets/rating_icon_widget.dart';

class RestaurantDetailsPage extends StatelessWidget {
  final RestaurantEntity restaurantEntity;
  const RestaurantDetailsPage({Key? key, required this.restaurantEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(restaurantEntity);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          restaurantEntity.name,
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon:
                const Icon(Icons.favorite_border_rounded, color: Colors.black),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<RestaurantDetailsBloc, RestaurantDetailsState>(
        builder: (context, state) {
          if (state is RestaurantDetailsEmpty) {
            context
                .read<RestaurantDetailsBloc>()
                .add(OnRequestedRestaurantDetails(restaurantEntity.id));
            return Container();
          }
          if (state is RestaurantDetailsLoading) {
            return const Center(child: CustomProgressIndicator());
          }
          if (state is RestaurantDetailsLoadFail) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  key: Key('error'),
                  child: Text('Error'),
                ),
                const SizedBox(
                  height: 20,
                ),
                IconButton(
                  onPressed: () => context
                      .read<RestaurantDetailsBloc>()
                      .add(OnRequestedRestaurantDetails(restaurantEntity.id)),
                  icon: const Icon(Icons.refresh),
                ),
              ],
            );
          }
          if (state is RestaurantDetailsLoaded) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        image: NetworkImage(restaurantEntity.photos.first),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              '${restaurantEntity.price} - ${restaurantEntity.categories.first.title}',
                            ),
                            IsOpenWidget(
                              isOpen: restaurantEntity.isOpenNow ?? false,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        const Text('Address'),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          state.result.address,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        const Text('Overral Rating'),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              state.result.rating.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            const Icon(Icons.star,
                                color: Color.fromARGB(255, 238, 214, 2)),
                          ],
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Text("${state.result.reviewCount} Reviews"),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: restaurantEntity.review.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                    const SizedBox(height: 30,),
                                RatingIcon(
                                  rating:
                                      restaurantEntity.review[index].rating,
                                ),
                                    const SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                            restaurantEntity
                                                .review[index].user.imageUrl,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Text(restaurantEntity
                                                .review[index].user.name,)
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
