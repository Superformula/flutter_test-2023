import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:restaurantour/presentation/app/l10n/l10n.dart';
import 'package:restaurantour/presentation/app/router/app_router.dart';
import 'package:restaurantour/presentation/app/state_management/favorites_cubit/favorites_cubit.dart';
import 'package:restaurantour/presentation/app/themes/themes.dart';

import 'helpers.dart';

class MockAppRouter extends Mock implements AppRouter {}

class MockFavoritesCubit extends MockBloc<FavoritesCubit, FavoritesState>
    implements FavoritesCubit {
  @override
  FavoritesState get state => const FavoritesState.loaded(restaurants: []);
}

extension AppTester on WidgetTester {
  Future<void> pumpApp(
    Widget widgetUnderTest, {
    FavoritesCubit? favoritesCubit,
    TargetPlatform? platform,
    GoRouter? goRouter,
  }) async {
    await mockNetworkImagesFor(
      () => pumpWidget(
        BlocProvider.value(
          value: favoritesCubit ?? MockFavoritesCubit(),
          child: MockGoRouterProvider(
            goRouter: goRouter ?? MockGoRouter(),
            child: MaterialApp(
              title: 'RestauranTour',
              theme: lightAppThemeData(),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: Scaffold(body: SafeArea(child: widgetUnderTest)),
            ),
          ),
        ),
      ),
    );
    await pump();
  }
}
