import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:restaurantour/home/home.dart';

import 'package:restaurantour/l10n/l10n.dart';
import 'package:restaurantour_ui/restaurantour_ui.dart';

class App extends StatelessWidget {
  const App({Key? key, required RestaurantRepository restaurantRepository})
      : _restaurantRepository = restaurantRepository,
        super(key: key);
  final RestaurantRepository _restaurantRepository;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider.value(value: _restaurantRepository)],
      child: MaterialApp(
        title: 'RestauranTour',
        theme: RestaurantourTheme.standard,
        home: const HomePage(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
