import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurant_details/bloc/restaurant_details_cubit.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurant_details/bloc/restaurant_details_state.dart';
import 'package:restaurantour/features/restaurant/presentation/restaurant_details/restaurant_details_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../restaurant_mockup.dart';

class MockRestaurantDetailsCubit extends MockCubit<RestaurantDetailState>
    implements RestaurantDetailCubit {}

void main() {
  late RestaurantDetailCubit mockRestaurantDetailsCubit;

  setUp(() {
    mockRestaurantDetailsCubit = MockRestaurantDetailsCubit();

    GetIt.I
        .registerSingleton<RestaurantDetailCubit>(mockRestaurantDetailsCubit);
  });

  tearDown(() {
    GetIt.I.unregister<RestaurantDetailCubit>();
  });

  testWidgets('RestaurantDetailsPage should show restaurant details',
      (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      final state = RestaurantDetailLoaded(
        restaurant: restaurantMockup,
        isFavorited: false,
      );
      when(() => mockRestaurantDetailsCubit.state).thenReturn(state);
      when(
        () =>
            mockRestaurantDetailsCubit.fetchRestaurantDetail(restaurantMockup),
      ).thenAnswer((_) async {});
      when(() => mockRestaurantDetailsCubit.stream).thenAnswer(
        (_) => Stream<RestaurantDetailState>.value(state),
      );

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          initialRoute: '/',
          routes: {
            '/': (context) => TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/restaurantDetails',
                      arguments: restaurantMockup,
                    );
                  },
                  child: const Text('Go to Restaurant Details'),
                ),
            '/restaurantDetails': (context) => const RestaurantDetailsPage(),
          },
        ),
      );
      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();
      expect(find.text(restaurantMockup.name!), findsOneWidget);
    });
  });
}
