import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/Modules/Details/view/widgets/review_card.dart';
import 'package:restaurantour/Modules/Details/viewmodel/detail_state.dart';
import 'package:restaurantour/Modules/Details/viewmodel/detail_viewmodel.dart';
import 'package:restaurantour/Modules/Home/tabs/widgets/categorie_text.dart';
import 'package:restaurantour/Modules/Home/tabs/widgets/is_open_label.dart';
import 'package:restaurantour/Modules/Home/tabs/widgets/price_text.dart';

class DetailView extends StatelessWidget {
  const DetailView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DetailViewmodel detailViewmodel =
        BlocProvider.of<DetailViewmodel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            detailViewmodel.restaurant.name!,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        actions: [
          BlocBuilder<DetailViewmodel, DetailState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () async {
                  await detailViewmodel.invertFavoriteValue();
                  await detailViewmodel.addtoFavorites();
                },
                icon: (detailViewmodel.restaurant.isFavorite)
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_outline),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: detailViewmodel.restaurant.photos != null
                  ? Image.network(
                      detailViewmodel.restaurant.photos!.first,
                      fit: BoxFit.cover,
                    )
                  : const Text('no photo'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      PriceText(
                        text: detailViewmodel.restaurant.price,
                        // text: 'homeViewmodel.restaurants.restaurants![index].price',
                      ),
                      CategorieText(
                        text: detailViewmodel.restaurant.categories?[0].title,
                      ),
                      const Expanded(
                        child: IsOpenLabel(
                          isOpen: true,
                        ),
                      ),
                      // 'text: homeViewmodel.restaurants.restaurants![index].categories?[0].title')
                    ],
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  const SizedBox(height: 32),
                  const Text('Adress'),
                  const SizedBox(height: 32),
                  Text(
                    detailViewmodel.restaurant.location?.formattedAddress ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  const SizedBox(height: 32),
                  const Text('Overall Rating'),
                  const SizedBox(height: 18),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        detailViewmodel.restaurant.rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Icon(
                          Icons.star,
                          size: 14,
                          color: Color.fromARGB(255, 255, 205, 40),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    detailViewmodel.restaurant.reviews!.length.toString() +
                        (detailViewmodel.restaurant.reviews!.length > 1
                            ? ' Reviews'
                            : 'Review'),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: (200.toInt() *
                            detailViewmodel.restaurant.reviews!.length)
                        .toDouble(),
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: detailViewmodel.restaurant.reviews?.length,
                      padding: const EdgeInsets.only(top: 10),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ReviewCard(
                              review:
                                  detailViewmodel.restaurant.reviews![index],
                            ),
                            const SizedBox(height: 18),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            const SizedBox(height: 32),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
