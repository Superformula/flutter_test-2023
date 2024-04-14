// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_restaurant_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailsRestaurantController on DetailsRestaurantControllerBase, Store {
  late final _$statusAtom =
      Atom(name: 'DetailsRestaurantControllerBase.status', context: context);

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

  @override
  String toString() {
    return '''
status: ${status}
    ''';
  }
}
