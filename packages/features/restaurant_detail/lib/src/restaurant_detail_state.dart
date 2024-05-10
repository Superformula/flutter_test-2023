part of 'restaurant_detail_cubit.dart';

class RestaurantDetailState extends Equatable {
  final PageStatus pageStatus;
  final int pageIndex;
  final List<Review> reviews;
  final bool isLastPage;

  const RestaurantDetailState({
    this.pageStatus = PageStatus.intial,
    this.pageIndex = 0,
    this.reviews = const [],
    this.isLastPage = false,
  });

  @override
  List<Object?> get props => [pageStatus, pageIndex, reviews, isLastPage];

  RestaurantDetailState copyWith({
    PageStatus? pageStatus,
    int? pageIndex,
    List<Review>? reviews,
    bool? isLastPage,
  }) =>
      RestaurantDetailState(
        pageStatus: pageStatus ?? this.pageStatus,
        pageIndex: pageIndex ?? this.pageIndex,
        reviews: reviews ?? this.reviews,
        isLastPage: isLastPage ?? this.isLastPage,
      );
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
