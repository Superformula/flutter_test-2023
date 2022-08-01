import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:restaurantour/restaurant_detail/cubit/restaurant_detail_cubit.dart';
import 'package:restaurantour/restaurant_detail/view/restaurant_detail_page.dart';
import 'package:restaurantour/restaurant_detail/widgets/restaurant_detail_information.dart';
import 'package:user_repository/user_repository.dart';

import '../../helpers/helpers.dart';

class MockRestaurantDetailCubit extends MockCubit<RestaurantDetailState>
    implements RestaurantDetailCubit {}

void main() {
  group('RestaurantDetailPage', () {
    late RestaurantRepository restaurantRepository;
    late UserRepository userRepository;
    setUp(() {
      restaurantRepository = MockRestaurantRepository();
      userRepository = MockUserRepository();

      when(() => restaurantRepository.restaurants)
          .thenAnswer((_) => const Stream.empty());
      when(() => userRepository.favorites)
          .thenAnswer((_) => const Stream.empty());
    });
    testWidgets('renders RestaurantDetailView', (WidgetTester tester) async {
      await tester.pumpApp(
        const RestaurantDetailPage(
          restaurantId: '',
        ),
        restaurantRepository: restaurantRepository,
        userRepository: userRepository,
      );
      expect(find.byType(RestaurantDetailView), findsOneWidget);
    });
  });

  group('RestaurantDetailView', () {
    late RestaurantDetailCubit restaurantDetailCubit;
    setUp(() {
      restaurantDetailCubit = MockRestaurantDetailCubit();
      when(() => restaurantDetailCubit.state)
          .thenReturn(const RestaurantDetailState(restaurantId: ''));
    });

    Widget buildSubject({int initialIndex = 0}) {
      return BlocProvider.value(
        value: restaurantDetailCubit,
        child: const RestaurantDetailView(),
      );
    }

    testWidgets(
      'render CircleProgressIndicator'
      'when status is initial',
      (WidgetTester tester) async {
        when(() => restaurantDetailCubit.state).thenReturn(
          const RestaurantDetailState(
            restaurantId: '',
            status: RestaurantDetailStatus.initial,
          ),
        );
        await tester.pumpApp(buildSubject());
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'render RestaurantDetailInformation '
      'when status is loaded',
      (WidgetTester tester) async {
        when(() => restaurantDetailCubit.state).thenReturn(
          const RestaurantDetailState(
            restaurantId: '',
            restaurant: Restaurant.empty,
            status: RestaurantDetailStatus.loaded,
          ),
        );
        await tester.pumpApp(buildSubject());
        expect(find.byType(RestaurantDetailInformation), findsOneWidget);
      },
    );
    testWidgets(
      'render Icons.error '
      'when status is error',
      (WidgetTester tester) async {
        when(() => restaurantDetailCubit.state).thenReturn(
          const RestaurantDetailState(
            restaurantId: '',
            status: RestaurantDetailStatus.error,
          ),
        );
        await tester.pumpApp(buildSubject());
        expect(find.byIcon(Icons.error), findsOneWidget);
      },
    );
  });
}
