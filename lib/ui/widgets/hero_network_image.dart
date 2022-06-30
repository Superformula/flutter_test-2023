import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurantour/ui/ui.dart';

class HeroNetworkImage extends StatelessWidget {
  final String imageUrl;
  final String? heroTag;
  final double? width;
  final double? height;

  const HeroNetworkImage({
    Key? key,
    required this.imageUrl,
    required this.heroTag,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: Key('hero-image-$heroTag'),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: width,
        height: width,
        placeholder: (_, __) => Container(color: AppColor.placeHolder),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
