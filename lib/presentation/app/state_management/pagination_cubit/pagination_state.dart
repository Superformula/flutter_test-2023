
part of 'pagination_cubit.dart';

class PaginationState<T> extends Equatable {
  const PaginationState({
    this.items = const [],
    this.newItems = const [],
    this.currentPage = 0,
    this.sort,
    this.itemsPerPage,
    this.filters = const {},
  });

  final List<T> items;
  final List<T> newItems;
  final int currentPage;
  final int? itemsPerPage;
  final String? sort;
  final Map<String, dynamic> filters;

  @override
  List<Object?> get props => [
        items,
        newItems,
        currentPage,
        sort,
        itemsPerPage,
        filters,
      ];

  PaginationState<T> copyWith({
    List<T>? items,
    List<T>? newItems,
    int? currentPage,
    String? sort,
    int? itemsPerPage,
    Map<String, dynamic>? filters,
  }) {
    return PaginationState<T>(
      items: items ?? this.items,
      newItems: newItems ?? this.newItems,
      currentPage: currentPage ?? this.currentPage,
      sort: sort ?? this.sort,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      filters: filters ?? this.filters,
    );
  }
}

class PaginationInitial<T> extends PaginationState<T> {
  const PaginationInitial({
    super.sort,
    super.itemsPerPage,
    super.filters = const {},
  });
}

class PaginationLoading<T> extends PaginationState<T> {
  const PaginationLoading({
    super.sort,
    super.items = const [],
    super.newItems = const [],
    super.currentPage = 0,
    super.itemsPerPage,
    super.filters = const {},
  });

  factory PaginationLoading.fromState(PaginationState<T> state) =>
      PaginationLoading(
        items: state.items,
        newItems: state.newItems,
        currentPage: state.currentPage,
        sort: state.sort,
        itemsPerPage: state.itemsPerPage,
        filters: state.filters,
      );
}

class PaginationError<T> extends PaginationState<T> {
  const PaginationError({
    required this.errorMessage,
    super.sort,
    super.items = const [],
    super.newItems = const [],
    super.currentPage = 0,
    super.itemsPerPage,
    super.filters = const {},
  });

  final String errorMessage;
}
