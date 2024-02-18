import 'package:flutter/material.dart';
import 'package:restaurantour/core/rt_colors.dart';
import 'package:restaurantour/core/inject.dart';
import 'package:restaurantour/features/restaurants_list/restaurants_list_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjection();

  runApp(const RestauranTour());
}

class RestauranTour extends StatelessWidget {
  const RestauranTour({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: const ColorScheme.light(
          primary: RTColors.primaryFill,
          onSurface: RTColors.secondaryText,
          background: RTColors.background,
        ),
      ),
      home: RestaurantsListScreen.create(),
    );
  }
}
