abstract class MyFavoritesState {}

class InitialState extends MyFavoritesState {}

class LoadingState extends MyFavoritesState {}

class LoadedState extends MyFavoritesState {}

class ErrorState extends MyFavoritesState {
  ErrorState(this.message);
  final String message;
}
