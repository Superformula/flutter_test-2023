part of 'restaurant_list_cubit.dart';

class RestaurantListState extends Equatable {
  final PageStatus pageStatus;
  final int pageIndex;
  final List<Restaurant> restaurants;
  final bool isLastPage;

  const RestaurantListState({
    this.pageStatus = PageStatus.intial,
    this.pageIndex = 0,
    this.restaurants = const [],
    this.isLastPage = false,
  });

  RestaurantListState copyWith({
    PageStatus? pageStatus,
    int? pageIndex,
    List<Restaurant>? restaurants,
    bool? isLastPage,
  }) =>
      RestaurantListState(
        pageStatus: pageStatus ?? this.pageStatus,
        pageIndex: pageIndex ?? this.pageIndex,
        restaurants: restaurants ?? this.restaurants,
        isLastPage: isLastPage ?? this.isLastPage,
      );

  @override
  List<Object?> get props => [pageStatus, pageIndex, restaurants, isLastPage];
}

enum PageStatus {
  /// The user has just opened the screen and the app must display the loading 
  /// to the entire page.
  intial,

  /// The app has already fetched the data and the user can see the content.
  success,

  /// The app has failed to fetch the data and the user must see an error 
  /// message.
  error,
}

extension PageStatusX on PageStatus {
  bool get isInitial => this == PageStatus.intial;
  bool get isSuccess => this == PageStatus.success;
  bool get isError => this == PageStatus.error;
}
