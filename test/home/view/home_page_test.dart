import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:restaurantour/home/home.dart';

import '../../helpers/pump_app.dart';

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {
  late RestaurantRepository restaurantRepository;
  group('HomePage', () {
    setUp(() {
      restaurantRepository = MockRestaurantRepository();
      when(() => restaurantRepository.restaurants)
          .thenAnswer((_) => const Stream.empty());
    });
    testWidgets('renders HomeView', (WidgetTester tester) async {
      await tester.pumpApp(
        const HomePage(),
        restaurantRepository: restaurantRepository,
      );
      expect(find.byType(HomeView), findsOneWidget);
    });
  });

  group('HomeView', () {
    late HomeCubit homeCubit;
    setUp(() {
      homeCubit = MockHomeCubit();
      when(() => homeCubit.state).thenReturn(const HomeState());
    });

    Widget buildSubject({int initialIndex = 0}) {
      return BlocProvider.value(
        value: homeCubit,
        child: HomeView(
          initialIndex: initialIndex,
        ),
      );
    }

    testWidgets(
      'render CircleProgressIndicator'
      'when allRestaurantsStatus is initial',
      (WidgetTester tester) async {
        when(() => homeCubit.state).thenReturn(
          const HomeState(
            allRestaurantsStatus: HomeListStatus.initial,
          ),
        );
        await tester.pumpApp(buildSubject());
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'render ListView'
      'when allRestaurantsStatus is loaded',
      (WidgetTester tester) async {
        when(() => homeCubit.state).thenReturn(
          const HomeState(
            allRestaurantsStatus: HomeListStatus.loaded,
          ),
        );
        await tester.pumpApp(buildSubject());
        expect(find.byType(ListView), findsOneWidget);
      },
    );
    testWidgets(
      'render ViewMoreButton '
      'when allRestaurantsStatus is loaded and scrolled to the bottom',
      (WidgetTester tester) async {
        when(() => homeCubit.state).thenReturn(
          const HomeState(
            allRestaurantsStatus: HomeListStatus.loaded,
          ),
        );
        await tester.pumpApp(buildSubject());
        await tester.drag(find.byType(ListView), const Offset(0, -1000));
        await tester.pump();
        expect(find.byType(ViewMoreButton), findsOneWidget);
      },
    );

    testWidgets(
      'render Icons.error'
      'when allRestaurantsStatus is error',
      (WidgetTester tester) async {
        when(() => homeCubit.state).thenReturn(
          const HomeState(
            allRestaurantsStatus: HomeListStatus.error,
          ),
        );
        await tester.pumpApp(buildSubject());
        expect(find.byIcon(Icons.error), findsOneWidget);
      },
    );

    testWidgets(
      'does not render ViewMoreButton '
      'when allRestaurantsStatus is completed and scrolled to the bottom',
      (WidgetTester tester) async {
        when(() => homeCubit.state).thenReturn(
          const HomeState(
            allRestaurantsStatus: HomeListStatus.completed,
          ),
        );
        await tester.pumpApp(buildSubject());
        await tester.drag(find.byType(ListView), const Offset(0, -1000));
        await tester.pump();
        expect(find.byType(ViewMoreButton), findsNothing);
      },
    );

    testWidgets(
      'render CircleProgressIndicator'
      'when favoritesStatus is initial',
      (WidgetTester tester) async {
        when(() => homeCubit.state).thenReturn(
          const HomeState(
            favoritesStatus: HomeListStatus.initial,
          ),
        );
        await tester.pumpApp(
          buildSubject(initialIndex: 1),
        );
        expect(
          find.byType(CircularProgressIndicator),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'render ListView'
      'when favoritesStatus is loaded',
      (WidgetTester tester) async {
        when(() => homeCubit.state).thenReturn(
          const HomeState(
            favoritesStatus: HomeListStatus.loaded,
          ),
        );
        await tester.pumpApp(
          buildSubject(initialIndex: 1),
        );
        expect(
          find.byType(ListView),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'render Icons.error'
      'when favoritesStatus is error',
      (WidgetTester tester) async {
        when(() => homeCubit.state).thenReturn(
          const HomeState(
            favoritesStatus: HomeListStatus.error,
          ),
        );
        await tester.pumpApp(
          buildSubject(initialIndex: 1),
        );
        expect(
          find.byIcon(Icons.error),
          findsOneWidget,
        );
      },
    );
  });
}
