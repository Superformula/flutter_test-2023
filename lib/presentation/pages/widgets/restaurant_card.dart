import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantour/domain/entities/restaurant_entity.dart';
import 'package:restaurantour/injection_container.dart';
import 'package:restaurantour/presentation/bloc/restaurant_details_bloc/restaurant_details_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurant_details_page/restaurant_details_page.dart';
import 'package:restaurantour/presentation/pages/widgets/is_open_widget.dart';
import 'package:restaurantour/presentation/pages/widgets/rating_icon_widget.dart';

class RestaurantListCard extends StatelessWidget {
  final RestaurantEntity restaurantEntity;
  const RestaurantListCard({Key? key, required this.restaurantEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => locator<RestaurantDetailsBloc>(),
                ),
              ],
              child: RestaurantDetailsPage(restaurantEntity: restaurantEntity),
            ),
          ),
        ),
      },
      child: SizedBox(
        height: 110,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  NetworkImage(restaurantEntity.photos.first),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: SizedBox(
                            width: 200,
                            height: 2,
                            child: Text(
                              restaurantEntity.name,
                              overflow: TextOverflow.visible,
                              maxLines: 2,
                              style: GoogleFonts.lora(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                          '${restaurantEntity.price} - ${restaurantEntity.categories.first.title}'),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          RatingIcon(rating: restaurantEntity.rating),
                          IsOpenWidget(
                            isOpen: restaurantEntity.isOpenNow ?? false,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
