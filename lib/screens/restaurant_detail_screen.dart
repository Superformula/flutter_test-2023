import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurantour/contants/text_style_constants.dart';
import 'package:restaurantour/widgets/review_card_widget.dart';

class RestaurantDetailScreen extends StatefulWidget {
  const RestaurantDetailScreen({Key? key, required this.restaurantId})
      : super(key: key);

  final String restaurantId;

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  late List<ReviewCardWidget> reviews;

  @override
  void initState() {
    super.initState();
    //Populate the reviews list
    reviews = const [
      ReviewCardWidget(),
      ReviewCardWidget(),
      ReviewCardWidget(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Restaurants Name Goes Here sdasfs',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 361,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.pexels.com/photos/262978/pexels-photo-262978.jpeg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'price and category',
                      style: TextStylesClass.priceCategoryTextStyle,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Open Now',
                          style: TextStylesClass.openCloseRestaurantTextStyle,
                        ),
                        const Gap(6),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(24),
                const Divider(),
                const Gap(24),
                Text(
                  'Address',
                  style: TextStylesClass.captionTextStyle,
                ),
                const Gap(24),
                Text(
                  '102 Lakeside Ave',
                  style: TextStylesClass.restaurantAddressTextStyle,
                ),
                Text(
                  'Seattle, WA 98122',
                  style: TextStylesClass.restaurantAddressTextStyle,
                ),
                const Gap(24),
                const Divider(),
                const Gap(24),
                Text(
                  'Overall Rating',
                  style: TextStylesClass.captionTextStyle,
                ),
                const Gap(24),
                Row(
                  children: [
                    Text(
                      '4.6',
                      style: GoogleFonts.lora(
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                      ),
                    ),
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ],
                ),
                const Gap(24),
                const Divider(),
                const Gap(24),
                Text(
                  '${reviews.length} Reviews',
                  style: TextStylesClass.captionTextStyle,
                ),
                const Gap(24),
                //show/loop through reviews - except the last one
                for (int i = 0; i < reviews.length - 1; i++) ...[
                  reviews[i],
                  const Divider(),
                ],

                //show the last review (without the divider at the end)
                reviews.isNotEmpty ? reviews.last : Container(),
                const Gap(100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
