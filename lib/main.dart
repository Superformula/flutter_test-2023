import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:restaurantour/core/dependecy_injection.dart';
import 'package:restaurantour/core/hive/hive.dart';
import 'package:restaurantour/features/restaurant/restaurant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  initDependencies();
  initRestaurantDependecies();
  runApp(const Restaurantour());
}

class Restaurantour extends StatelessWidget {
  const Restaurantour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RestauranTour',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('pt'),
      ],
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const RestaurantListPage(),
      routes: {
        RestaurantDetailsPage.routeName: (context) =>
            const RestaurantDetailsPage(),
      },
    );
  }
}
