import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_tab_controller_state.dart';
part 'home_tab_controller_cubit.freezed.dart';

@injectable
class HomeTabControllerCubit extends Cubit<HomeTabControllerState> {
  HomeTabControllerCubit()
      : super(
          const HomeTabControllerState.allRestaurants(),
        );

  void changeToMyFavorites() {
    emit(const HomeTabControllerState.myFavorites());
  }

  void changeToAllRestaurants() {
    emit(const HomeTabControllerState.allRestaurants());
  }
}
