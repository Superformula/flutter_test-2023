import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  const ImageTile({
    Key? key,
    required this.url,
    this.width = 88,
    this.height = 88,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: BoxFit.fill,
      errorBuilder: (context, obj, error) => SizedBox(
        width: width,
        height: height,
        child: const Center(
          child: Icon(Icons.broken_image),
        ),
      ),
    );
  }
}
