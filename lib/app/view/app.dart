import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:restaurantour/home/home.dart';

import 'package:restaurantour/l10n/l10n.dart';
import 'package:restaurantour_ui/restaurantour_ui.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required RestaurantRepository restaurantRepository,
    required UserRepository userRepository,
  })  : _restaurantRepository = restaurantRepository,
        _userRepository = userRepository,
        super(key: key);
  final RestaurantRepository _restaurantRepository;
  final UserRepository _userRepository;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _restaurantRepository),
        RepositoryProvider.value(value: _userRepository)
      ],
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
