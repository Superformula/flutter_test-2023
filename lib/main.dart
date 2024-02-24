import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:restaurantour/injection_container/config_dependencies.dart';
import 'package:restaurantour/presentation/app/l10n/l10n.dart';
import 'package:restaurantour/presentation/app/router/app_router.dart';
import 'package:restaurantour/presentation/app/state_management/favorites_cubit/favorites_cubit.dart';
import 'package:restaurantour/presentation/app/themes/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(const Restaurantour());
}

class Restaurantour extends StatefulWidget {
  const Restaurantour({Key? key}) : super(key: key);

  @override
  State<Restaurantour> createState() => _RestaurantourState();
}

class _RestaurantourState extends State<Restaurantour> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FavoritesCubit>(),
      child: MaterialApp.router(
        title: 'RestauranTour',
        theme: lightAppThemeData(),
        routerConfig: _appRouter.routes,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
