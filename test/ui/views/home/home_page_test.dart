import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:restaurantour/blocs/restaurants/restaurants_cubit.dart';
import 'package:restaurantour/ui/views/views.dart';

import '../../../helpers/helpers.dart';

class MockRestaurantsCubit extends MockCubit<RestaurantsState>
    implements RestaurantsCubit {}

void main() {
  group('HomeScreen', () {
    late RestaurantsCubit cubit;
    late MockNavigator navigator;

    setUp(() {
      cubit = MockRestaurantsCubit();
      navigator = MockNavigator();
      when(() => navigator.push(any())).thenAnswer((_) async => null);
    });

    Widget buildSubject() {
      return BlocProvider.value(
        value: cubit,
        child: const HomePage(),
      );
    }

    testWidgets('is rendered', (tester) async {
      when(() => cubit.state).thenReturn(RestaurantsState.initial());

      await tester.pumpApp(buildSubject());
      expect(find.byType(AppBar), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text('RestauranTour'),
        ),
        findsOneWidget,
      );
      expect(find.byType(Tab), findsNWidgets(2));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders a list of restaurants', (tester) async {
      when(() => cubit.state).thenReturn(RestaurantsState.initial());

      await tester.pumpApp(buildSubject());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
