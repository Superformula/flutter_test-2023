import 'package:flutter/material.dart';
import 'package:restaurantour/core/design_system/text_styles/restaurantour_text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OpenStatus extends StatelessWidget {
  const OpenStatus({Key? key, required this.isOpen}) : super(key: key);

  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          isOpen
              ? AppLocalizations.of(context)!.openNow
              : AppLocalizations.of(context)!.closed,
          style: RestaurantourTextStyles.overline,
        ),
        const SizedBox(width: 8),
        Icon(
          Icons.circle,
          color: isOpen ? Colors.green : Colors.red,
          size: 12,
        ),
      ],
    );
  }
}
