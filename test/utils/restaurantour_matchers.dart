import 'package:flutter_test/flutter_test.dart';

Matcher isNotSame<T>(T obj) => _IsNoSame(obj);

class _IsNoSame<T> extends Matcher {
  //
  final T obj;

  _IsNoSame(this.obj);

  @override
  bool matches(item, Map matchState) {
    if (item is! T) {
      throw ArgumentError('$item isn\'t $T.');
    } else {
      return !identical(item, obj);
    }
  }

  @override
  Description describe(Description description) {
    return description.add('$T instance different from').addDescriptionOf(obj);
  }
}
