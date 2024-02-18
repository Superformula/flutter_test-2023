import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RTEmptyWidget extends StatelessWidget {
  const RTEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
            child: Icon(Icons.search, size: 100),
          ),
          const SizedBox(height: 40),
          Text(
            AppLocalizations.of(context)!.emptyMessage,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
