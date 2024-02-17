abstract class HomeState {}

class InitialState extends HomeState {}

class LoadingState extends HomeState {}

class LoadedState extends HomeState {}

class ErrorState extends HomeState {
  ErrorState(this.message);
  final String message;
}
