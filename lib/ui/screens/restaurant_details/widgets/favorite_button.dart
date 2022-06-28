import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  final bool isFavorite;
  final VoidCallback onToggle;

  const FavoriteButton({
    Key? key,
    required this.isFavorite,
    required this.onToggle,
  }) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        widget.onToggle();
        setState(() {
          _isFavorite = !_isFavorite;
        });
      },
      icon: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
      ),
    );
  }
}
