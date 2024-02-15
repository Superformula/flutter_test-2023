import 'package:flutter/material.dart';

import 'package:restaurantour/pages/details_page.dart';
import 'package:restaurantour/utils/strings.dart';

import 'handlers/error_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  registerErrorHandlers();

  runApp(const Restaurantour());
}

class Restaurantour extends StatelessWidget {
  const Restaurantour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.title,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const DetailsPage(),
    );
  }
}
