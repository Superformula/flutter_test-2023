import 'package:flutter/material.dart';

class NetworkImageHero extends StatelessWidget {
  final String? imageLink;
  final String heroId;
  const NetworkImageHero({
    Key? key,
    required this.imageLink,
    required this.heroId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroId,
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
    );
  }
}
