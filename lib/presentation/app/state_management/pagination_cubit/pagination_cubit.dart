import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

part 'pagination_state.dart';

typedef FetchItemCallBack<T> = Future<List<T>> Function({
  required int page,
  int? itemsPerPage,
  String? sort,
  Map<String, dynamic> filters,
});

@injectable
class PaginationCubit<T> extends Cubit<PaginationState<T>> {
  PaginationCubit({
    required this.pagingController,
    required this.fetchItemCallBack,
    String? sort,
    int? itemsPerPage,
    Map<String, dynamic> filters = const {},
  }) : super(
          PaginationInitial<T>(
            sort: sort,
            itemsPerPage: itemsPerPage ?? 50,
            filters: filters,
          ),
        ) {
    pagingController.addPageRequestListener(loadByPage);
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }

  final FetchItemCallBack<T> fetchItemCallBack;
  final PagingController<int, T> pagingController;

  Future<void> loadByPage(int page) async {
    final initialProps = state.props;
    try {
      emit(PaginationLoading.fromState(state));
      late List<T> newItems;
      newItems = await fetchItemCallBack(
        page: state.currentPage,
        itemsPerPage: state.itemsPerPage,
        sort: state.sort,
        filters: state.filters,
      );

      final deepEquals = const DeepCollectionEquality().equals;
      if (!deepEquals(initialProps, state.props)) {
        await loadByPage(page);
        return;
      }

      final allItems = [...state.items, ...newItems];

      _appendItems(newItems: newItems, newPage: allItems.length);

      emit(
        PaginationState(
          newItems: newItems,
          items: allItems,
          currentPage: state.currentPage + 1,
          sort: state.sort,
          itemsPerPage: state.itemsPerPage,
          filters: state.filters,
        ),
      );
    } on Exception catch (e, _) {
      if (!isClosed) {
        emit(
          PaginationError(
            items: state.items,
            errorMessage: 'Error loading data, please try again later.',
            sort: state.sort,
            itemsPerPage: state.itemsPerPage,
            filters: state.filters,
          ),
        );
      }
    }
  }

  void _appendItems({required List<T> newItems, required int newPage}) {
    final isLastPage = newItems.isEmpty;

    if (isLastPage) {
      pagingController.appendLastPage(newItems);
    } else {
      pagingController.appendPage(newItems, newPage);
    }
  }

  void addFilter({
    required String filterKey,
    required dynamic filterValue,
  }) =>
      emit(
        state.copyWith(
          filters: {
            ...state.filters,
            filterKey: filterValue,
          },
        ),
      );

  void setFilters({
    required Map<String, dynamic> filters,
  }) =>
      emit(
        state.copyWith(
          filters: filters,
        ),
      );

  void removeFilter({
    required String filterKey,
  }) {
    final newFilters = Map<String, dynamic>.from(state.filters)
      ..remove(filterKey);
    emit(
      state.copyWith(
        filters: newFilters,
      ),
    );
  }

  void clearAllFilter() => emit(
        state.copyWith(
          filters: {},
        ),
      );

  void updateSort({required String sort}) {
    emit(
      state.copyWith(
        sort: sort,
      ),
    );
    refreshList();
  }

  void refreshList() {
    emit(
      state.copyWith(
        items: [],
        currentPage: 0,
        newItems: [],
      ),
    );
    pagingController.refresh();
  }

  void updateItem(T oldItem, T newItem) {
    final updatedItems = List<T>.from(state.items);
    final itemIndex = updatedItems.indexOf(oldItem);
    updatedItems[itemIndex] = newItem;

    pagingController.value = PagingState<int, T>(
      itemList: updatedItems,
      nextPageKey: state.currentPage,
    );
    emit(state.copyWith(items: updatedItems));
  }
}
