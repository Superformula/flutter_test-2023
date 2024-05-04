import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:local_storage/local_storage.dart';
import 'package:restaurant_detail/restaurant_detail.dart';
import 'package:restaurant_list/restaurant_list.dart';
import 'package:restaurantour/app_router.dart';
import 'package:yelp_repository/yelp_repository.dart';

void start() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localStorage = await LocalStorage.create();
  runApp(Restaurantour(localStorage: localStorage));
}

class Restaurantour extends StatelessWidget {
  final LocalStorage _localStorage;

  const Restaurantour({
    Key? key,
    required LocalStorage localStorage,
  })  : _localStorage = localStorage,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RestauranTour',
      supportedLocales: const [Locale('en', '')],
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        RestaurantListLocalizations.delegate,
        RestaurantDetailLocalizations.delegate,
      ],
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => AppRouter.generateRoute(
        settings,
        yelpRepository: YelpRepository(),
        localStorage: _localStorage,
      ),
      initialRoute: PageName.restaurantList,
    );
  }
}
