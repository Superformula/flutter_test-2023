
import 'package:flutter/material.dart';
import 'package:restaurantour/detail_view/detail_view_main.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/theme/app_color.dart';

class RestaurantRowItem extends StatelessWidget {
  final ThemeData theme;
  final Restaurant restaurant;
  final int index;

  RestaurantRowItem(this.theme, this.restaurant,
      this.index); // const RestaurantRowItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailViewMain(theme,restaurant,index)),
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
                          rating(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(isOpen() ? "Open Now" : "Closed",
                                style: theme.textTheme.overline!.copyWith(
                                  // wordSpacing: -2
                                    letterSpacing: -0.5
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(
                                  Icons.circle,
                                  color: isOpen() ? AppColor.open : AppColor.closed,
                                  size: 8.0,
                                ),
                              ),
                            ],
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

  Widget rating() {
    if (restaurant.rating != null) {
      List<Widget> children = [];
      for (var i = 0; i < restaurant.rating! ~/ 1; i++) {
        children.add(Icon(
          Icons.star,
          color: AppColor.star,
          size: 12.0,
        ));
      }
      if (restaurant.rating! % 1 == 0.5) {
        children.add(Icon(
          Icons.star_half,
          color: AppColor.star,
          size: 12.0,
        ));
      }
      return Row(children: children,);
    }else {
      return Container();
    }
  }

  bool isOpen() {
    if (restaurant.hours != null) {
      if (restaurant.hours!.first.isOpenNow != null) {
        if (restaurant.hours!.first.isOpenNow!) {
          return true;
        }else {
          return false;
        }
      }
    }
    return false;
  }
}
