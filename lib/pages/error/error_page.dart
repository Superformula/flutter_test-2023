import 'package:flutter/material.dart';
import 'package:restaurantour/localization/localization.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(context.l10n.error),
      ),
    );
  }
}
