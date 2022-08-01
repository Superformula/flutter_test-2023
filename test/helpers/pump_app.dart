import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:restaurantour/l10n/l10n.dart';
import 'package:user_repository/user_repository.dart';

class MockRestaurantRepository extends Mock implements RestaurantRepository {}

class MockUserRepository extends Mock implements UserRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    RestaurantRepository? restaurantRepository,
    UserRepository? userRepository,
  }) {
    return pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: restaurantRepository ?? MockRestaurantRepository(),
          ),
          RepositoryProvider.value(
            value: userRepository ?? MockUserRepository(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: widget),
        ),
      ),
    );
  }
}
