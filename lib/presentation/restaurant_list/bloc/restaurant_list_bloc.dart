import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:restaurantour/core/utils/utils.dart';
import 'package:restaurantour/domain/usecases/usecases.dart';
import 'package:restaurantour/presentation/restaurant_list/bloc/bloc.dart';

@injectable
class RestaurantListBloc
    extends Bloc<RestaurantListEvent, FavoriteRestaurantsListState> {
  final GetRestaurantsListUsecase _getRestaurantsListUsecase;

  RestaurantListBloc({
    required GetRestaurantsListUsecase getRestaurantsListUsecase,
  })  : _getRestaurantsListUsecase = getRestaurantsListUsecase,
        super(const FavoriteRestaurantsListState()) {
    on<GetRestaurantsListEvent>(_getRestaurantsList);
  }

  FutureOr<void> _getRestaurantsList(
    GetRestaurantsListEvent event,
    Emitter<FavoriteRestaurantsListState> emit,
  ) async {
    emit(state.copyWith(status: StatusEnum.loading));

    final failureOrSuccess =
        await _getRestaurantsListUsecase(params: const NoParams());

    failureOrSuccess.fold(
      (failure) => emit(state.copyWith(status: StatusEnum.failure)),
      (restaurants) => emit(
        state.copyWith(
          status: StatusEnum.success,
          restaurantsList: restaurants,
        ),
      ),
    );
  }
}
