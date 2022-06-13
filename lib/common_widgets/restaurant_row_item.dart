
import 'package:flutter/material.dart';
import 'package:restaurantour/common_widgets/is_open.dart';
import 'package:restaurantour/common_widgets/rating.dart';
import 'package:restaurantour/detail_view/detail_view_main.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/my_favorites/my_favorites_main.dart';

class RestaurantRowItem extends StatelessWidget {
  final ThemeData theme;
  final Restaurant restaurant;
  final int index;
  final GlobalKey<MyFavoritesMainState> myFavoriteKey;

  RestaurantRowItem(this.theme, this.restaurant,
      this.index, this.myFavoriteKey); // const RestaurantRowItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailViewMain(theme,restaurant,index,myFavoriteKey)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0,12,12,0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 0.5),
                blurRadius: 1.2,
              ),
            ],
          ),
          height: 104,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 88,
                  height: 88,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Hero(
                      tag: "restaurantPhoto$index",
                      child: Image.network(restaurant.photos?.first ?? "",fit: BoxFit.fill,)
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4,8,8,8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          restaurant.name ?? "Restaurant Name",
                          style: theme.textTheme.subtitle1!.copyWith(
                            height: 1.44
                          ),
                          // textAlign: TextAlign.,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text("${restaurant.price ?? "\$\$"} ${restaurant.categories?.first.title ?? ""}", style: theme.textTheme.caption,),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Rating(restaurant.rating),
                          IsOpen(theme, restaurant)
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
