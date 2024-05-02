import 'package:flutter/material.dart';
import 'package:local_storage/local_storage.dart';
import 'package:restaurantour/app_router.dart';
import 'package:yelp_repository/yelp_repository.dart';

void main() async {
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
