import 'package:flutter/material.dart';
import 'package:restaurantour/l10n/l10n.dart';

class ViewMoreButton extends StatelessWidget {
  const ViewMoreButton({
    Key? key,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);
  final bool isLoading;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    const double textButtonWidth = 120;
    const double textButtonHeight = 48;
    return SizedBox(
      width: textButtonWidth,
      height: textButtonHeight,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : TextButton(
              onPressed: onPressed,
              child: Text(
                l10n.homeViewMoreButtonText,
                style: Theme.of(context).textTheme.button,
              ),
            ),
    );
  }
}
