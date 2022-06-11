
import 'package:flutter/material.dart';
import 'package:restaurantour/theme/app_color.dart';

class RestaurantRowItem extends StatelessWidget {
  final ThemeData theme;

  RestaurantRowItem(
      this.theme); // const RestaurantRowItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
                    fit: BoxFit.fill,
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
                        "Restaurant Name Goes Here And Wraps 2 Lines",
                        style: theme.textTheme.subtitle1!.copyWith(
                          height: 1.44
                        ),
                        // textAlign: TextAlign.,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text("Italian", style: theme.textTheme.caption,),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColor.star,
                              size: 12.0,
                            ),
                            Icon(
                              Icons.star,
                              color: AppColor.star,
                              size: 12.0,
                            ),
                            Icon(
                              Icons.star,
                              color: AppColor.star,
                              size: 12.0,
                            ),
                            Icon(
                              Icons.star,
                              color: AppColor.star,
                              size: 12.0,
                            ),
                            Icon(
                              Icons.star,
                              color: AppColor.star,
                              size: 12.0,
                            ),
                          ],
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Open Now",
                              style: theme.textTheme.overline!.copyWith(
                                // wordSpacing: -2
                                letterSpacing: -0.5
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(
                                Icons.circle,
                                color: AppColor.open,
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
    );
  }
}
