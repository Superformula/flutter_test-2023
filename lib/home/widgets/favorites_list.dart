import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/l10n/l10n.dart';

import 'package:restaurantour_ui/restaurantour_ui.dart';

import '../home.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final favoritesStatus = context.watch<HomeCubit>().state.favoritesStatus;
    if (favoritesStatus == HomeListStatus.initial) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (favoritesStatus == HomeListStatus.error) {
      return const Center(
        child: Icon(Icons.error),
      );
    }
    return ListView.separated(
      key: const Key('homeView_favoritesList'),
      // TODO: change for real value
      itemCount: 10,
      padding: const EdgeInsets.symmetric(
        horizontal: RestaurantourPaddingValues.big,
        vertical: RestaurantourPaddingValues.l,
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: RestaurantourPaddingValues.big,
      ),
      itemBuilder: (context, index) {
        // TODO: Change for real value
        return RestaurantCard(
          title:
              'Restaurant Name Goes Here And Wraps 2 Lines Non fugiat sint mollit ut ullamco mollit et.',
          category: 'Italian',
          imageUrl: 'https://via.placeholder.com/150',
          rating: 5,
          price: '\$\$\$',
          openText: l10n.attentionStatusOpen,
          closedText: l10n.attentionStatusClosed,
          isOpenNow: true,
          defaultRestaurantName: l10n.defaultRestaurantName,
          heroTag: UniqueKey().toString(),
          onTap: () {},
        );
      },
    );
  }
}
