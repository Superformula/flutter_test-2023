// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on HomeControllerBase, Store {
  Computed<List<Restaurant>>? _$restaurantsFavoritsComputed;

  @override
  List<Restaurant> get restaurantsFavorits => (_$restaurantsFavoritsComputed ??=
          Computed<List<Restaurant>>(() => super.restaurantsFavorits,
              name: 'HomeControllerBase.restaurantsFavorits'))
      .value;

  late final _$statusAtom =
      Atom(name: 'HomeControllerBase.status', context: context);

  @override
  StatusType get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(StatusType value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$restaurantsAtom =
      Atom(name: 'HomeControllerBase.restaurants', context: context);

  @override
  ObservableList<Restaurant> get restaurants {
    _$restaurantsAtom.reportRead();
    return super.restaurants;
  }

  @override
  set restaurants(ObservableList<Restaurant> value) {
    _$restaurantsAtom.reportWrite(value, super.restaurants, () {
      super.restaurants = value;
    });
  }

  @override
  String toString() {
    return '''
status: ${status},
restaurants: ${restaurants},
restaurantsFavorits: ${restaurantsFavorits}
    ''';
  }
}
