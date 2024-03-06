import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CategoryEntity', () {
    test('should have the correct properties', () {
      const categoryEntity = (
        title: 'Italian',
        alias: 'italian',
      );

      expect(categoryEntity.title, 'Italian');
      expect(categoryEntity.alias, 'italian');
    });

    test('should support value equality', () {
      const categoryEntity1 = (
        title: 'Italian',
        alias: 'italian',
      );
      const categoryEntity2 = (
        title: 'Italian',
        alias: 'italian',
      );

      expect(categoryEntity1, equals(categoryEntity2));
    });

    test('should not be equal when properties differ', () {
      const categoryEntity1 = (
        title: 'Italian',
        alias: 'italian',
      );
      const categoryEntity2 = (
        title: 'Mexican',
        alias: 'mexican',
      );

      expect(categoryEntity1, isNot(equals(categoryEntity2)));
    });
  });
}
