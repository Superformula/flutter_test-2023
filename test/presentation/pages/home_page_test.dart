import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/business_logic/favorite/favorite_cubit.dart';
import 'package:restaurantour/business_logic/restaurants/restaurants_cubit.dart';
import 'package:restaurantour/business_logic/restaurants/restaurants_state.dart';
import 'package:restaurantour/presentation/pages/home_page.dart';
import 'package:restaurantour/presentation/widgets/restaurant_card_widget.dart';

class MockRestaurantsCubit extends MockCubit<RestaurantsState>
    implements RestaurantsCubit {}

late RestaurantsCubit cubit;

void main() {
  setUp(
    () => cubit = MockRestaurantsCubit(),
  );

  testWidgets('Find restaurants inital state', (tester) async {
    when(() => cubit.fetchRestaurants()).thenAnswer((_) => Future.value());

    when(() => cubit.state)
        .thenReturn(RestaurantsState(status: RestaurantsStatus.initial));

    await _createWidget(tester);

    expect(find.byKey(const Key('initial state')), findsOneWidget);
  });

  testWidgets('Find restaurants loading state', (tester) async {
    when(() => cubit.fetchRestaurants()).thenAnswer((_) => Future.value());

    when(() => cubit.state)
        .thenReturn(RestaurantsState(status: RestaurantsStatus.loading));

    await _createWidget(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Find restaurants success state', (tester) async {
    when(() => cubit.fetchRestaurants()).thenAnswer((_) => Future.value());

    when(() => cubit.state).thenReturn(
      RestaurantsState(
        status: RestaurantsStatus.success,
        restaurants: [const Restaurant(id: '1', name: 'POllos hermanos')],
      ),
    );

    await mockNetworkImagesFor(() => _createWidget(tester));

    expect(find.byType(RestaurantCardWidget), findsOneWidget);
  });
}

Future<void> _createWidget(WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: cubit,
          ),
          BlocProvider.value(
            value: FavoriteCubit(),
          ),
        ],
        child: const HomePage(),
      ),
    ),
  );
}
