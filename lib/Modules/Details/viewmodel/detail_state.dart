abstract class DetailState {}

class InitialState extends DetailState {}

class LoadingState extends DetailState {}

class LoadedState extends DetailState {}

class ErrorState extends DetailState {
  ErrorState(this.message);
  final String message;
}
