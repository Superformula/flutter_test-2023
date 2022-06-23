import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  final String url;
  const ImageTile({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: 88,
      height: 88,
      fit: BoxFit.fill,
      errorBuilder: (context, obj, error) => const SizedBox(
        width: 88,
        height: 88,
        child: Center(
          child: Icon(Icons.broken_image),
        ),
      ),
    );
  }
}
