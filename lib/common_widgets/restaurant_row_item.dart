
import 'package:flutter/material.dart';
import 'package:restaurantour/common_widgets/app_place_holder.dart';
import 'package:restaurantour/common_widgets/is_open.dart';
import 'package:restaurantour/common_widgets/rating.dart';
import 'package:restaurantour/detail_view/detail_view_main.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/my_favorites/my_favorites_main.dart';
import 'package:restaurantour/repositories/key_collection.dart';
import 'package:restaurantour/theme/app_theme.dart';

/// Common restaurant row Item
/// It uses for all restaurants and my favorites list.

class RestaurantRowItem extends StatelessWidget {
  final bool isLoading;
  final ThemeData? theme;
  final Restaurant? restaurant;
  final int? index;
  final GlobalKey<MyFavoritesMainState>? myFavoriteKey;

  const RestaurantRowItem([this.isLoading = false,this.theme, this.restaurant,
    this.index, this.myFavoriteKey,  Key? key]) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(!isLoading) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailViewMain(theme!,restaurant!,index!,myFavoriteKey!)),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0,12,12,0),
        child: Container( // Row Item decoration.
          decoration: AppTheme.restaurantRowDecoration,
          height: 104,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              restaurantThumbnail(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4,8,8,8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      restaurantName(),
                      priceAndCategory(),
                      ratingAndIsOpen(),
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

  ratingAndIsOpen() {
    return isLoading ? Column(  // Rating and isOpen
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Padding(
          padding: EdgeInsets.only(bottom: 4.0),
          child:AppPlaceHolder(height: 20, width: 28,),
        ),
        AppPlaceHolder(height: 12, width: 60,),
      ],
    ) :
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Rating(restaurant!.rating),
        IsOpen(theme!, restaurant!)
      ],
    );
  }

  priceAndCategory() {
    return Padding( // Price and Category
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: isLoading ? const AppPlaceHolder(height: 22) :
      Text(
        "${restaurant!.price ?? ""} ${restaurant!.categories?.first.title ?? ""}",
        style: theme!.textTheme.caption,
      ),
    );
  }

  restaurantName() {
    return isLoading ? const AppPlaceHolder(height: 22) : Expanded( // Restaurant Name
      child: Text(
        restaurant!.name ?? "Restaurant Name",
        maxLines: 2,
        style: theme!.textTheme.subtitle1!.copyWith(
            height: 1.44
        ),
      ),
    );
  }

  restaurantThumbnail() {
    return Padding( // Restaurant Image.
      padding: const EdgeInsets.all(8.0),
      child: isLoading ? const AppPlaceHolder(height:88,width:88) : SizedBox(
        width: 88,
        height: 88,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Hero(
              tag: "${GlobalKeyName.imageHero}$index",
              child: Image.network(restaurant!.photos?.first ?? "",fit: BoxFit.fill,)
          ),
        ),
      ),
    );
  }
}

