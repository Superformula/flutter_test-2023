
import 'package:flutter/material.dart';
import 'package:restaurantour/common_widgets/app_place_holder.dart';

class RestaurantRowItemPlaceHolder extends StatelessWidget {
  const RestaurantRowItemPlaceHolder({Key? key}) : super(key: key);

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
              child: AppPlaceHolder(height:88,width:88),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4,8,8,8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppPlaceHolder(height: 22),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child:AppPlaceHolder(height: 22),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child:
                      AppPlaceHolder(height: 20, width: 28,),
                    ),
                    AppPlaceHolder(height: 12, width: 60,),
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
