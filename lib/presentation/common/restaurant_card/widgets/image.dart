import 'package:flutter/material.dart';

class RestaurantCardImage extends StatelessWidget {
  final String? imageLink;
  const RestaurantCardImage(this.imageLink, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88.0,
      height: 88.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: imageLink != null
            ? Image.network(
                imageLink!,
                fit: BoxFit.cover,
              )
            : Container(
                color: Colors.black26,
                child: const Icon(
                  Icons.restaurant_outlined,
                  size: 32.0,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
