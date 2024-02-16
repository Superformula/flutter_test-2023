import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<InitialEvent>(_onInitialEvent);
  }

  Future<void> _onInitialEvent(
    InitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      HomeLoadingState(),
    );
  }
}
