import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/core/error/error.dart';
import 'package:restaurantour/core/utils/utils.dart';
import 'package:restaurantour/domain/entities/entities.dart';
import 'package:restaurantour/domain/usecases/usecases.dart';
import 'package:restaurantour/presentation/restaurant_list/bloc/bloc.dart';

import '../../../mocks/restaurant_mock.dart';

class MockGetRestaurantsListUsecase extends Mock
    implements GetRestaurantsListUsecase {}

void main() {
  late RestaurantListBloc restaurantListBloc;
  late GetRestaurantsListUsecase usecase;

  RestaurantEntity restaurant = RestaurantMock.restarantEntity;

  List<RestaurantEntity> restaurantsList = [restaurant];

  setUp(() async {
    usecase = MockGetRestaurantsListUsecase();
    restaurantListBloc = RestaurantListBloc(getRestaurantsListUsecase: usecase);
  });

  blocTest<RestaurantListBloc, FavoriteRestaurantsListState>(
    'emits [StatusEnum.success] when GetRestaurantsListEvent is added.',
    setUp: () {
      when(() => usecase(params: const NoParams())).thenAnswer(
        (_) async => Right(restaurantsList),
      );
    },
    build: () => restaurantListBloc,
    act: (bloc) => bloc.add(GetRestaurantsListEvent()),
    expect: () => <FavoriteRestaurantsListState>[
      const FavoriteRestaurantsListState(status: StatusEnum.loading),
      FavoriteRestaurantsListState(
        status: StatusEnum.success,
        restaurantsList: restaurantsList,
      ),
    ],
  );

  blocTest<RestaurantListBloc, FavoriteRestaurantsListState>(
    'emits [StatusEnum.failure] when GetRestaurantsListEvent fails.',
    setUp: () {
      when(() => usecase(params: const NoParams())).thenAnswer(
        (_) async => const Left(RestaurantListFailure()),
      );
    },
    build: () => restaurantListBloc,
    act: (bloc) => bloc.add(GetRestaurantsListEvent()),
    expect: () => <FavoriteRestaurantsListState>[
      const FavoriteRestaurantsListState(status: StatusEnum.loading),
      const FavoriteRestaurantsListState(status: StatusEnum.failure),
    ],
  );
}
