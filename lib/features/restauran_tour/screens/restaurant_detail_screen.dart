import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/features/restauran_tour/model/restaurant.dart';
import 'package:restaurantour/features/restauran_tour/view_model/restaurants_view_model.dart';
import 'package:restaurantour/theme/app_color.dart';
import 'package:restaurantour/widgets/open_status.dart';

class ResturantDetailScreen extends StatelessWidget {
  const ResturantDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Restaurant viewModel =
    //     context.watch<RestaurantsViewModel>().selectedRestaurant;

    RestaurantsViewModel viewModel = context.watch<RestaurantsViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          viewModel.selectedRestaurant.name ?? "",
          style: Theme.of(context).textTheme.headline6,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          InkWell(
            onTap: () {
              viewModel
                  .addOrRemoveFavorite(viewModel.selectedRestaurant.id ?? "");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: viewModel.isFavorite()
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imageDisplay(context, viewModel.selectedRestaurant.heroImage),
            _detailContent(context, viewModel.selectedRestaurant),
          ],
        ),
      ),
    );
  }

  Widget _imageDisplay(BuildContext context, String heroImage) {
    return SizedBox(
      child: Hero(
        tag: heroImage,
        child: Image.network(
          heroImage,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _detailContent(BuildContext context, Restaurant viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _priceAndStatus(context, viewModel),
          const Divider(),
          _address(context, viewModel),
          const Divider(),
          _rating(context, viewModel),
          const Divider(),
        ],
      ),
    );
  }

  Widget _rating(BuildContext context, Restaurant viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Overall Rating",
          style: Theme.of(context).textTheme.caption,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(children: [
            Text(
              viewModel.rating.toString(),
              style: Theme.of(context).textTheme.headline6,
            ),
            Icon(
              Icons.star,
              color: AppColors.star,
              size: 12,
            ),
          ]),
        )
      ],
    );
  }

  Widget _priceAndStatus(BuildContext context, Restaurant viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${viewModel.price} ${viewModel.categories?.first.title ?? ""}",
            style: Theme.of(context).textTheme.caption,
          ),
          OpenStatus(viewModel.isOpen)
        ],
      ),
    );
  }

  Widget _address(BuildContext context, Restaurant viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Address",
          style: Theme.of(context).textTheme.caption,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            viewModel.location?.formattedAddress ?? "",
            style: Theme.of(context).textTheme.caption,
          ),
        )
      ],
    );
  }
}
