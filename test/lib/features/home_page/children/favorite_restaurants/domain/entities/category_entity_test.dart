import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/domain/entities/category_entity.dart';

void main() {
  group(
    'CategoryEntity',
    () {
      test('should have the correct properties', () {
        const title = 'Italian';
        const alias = 'italian';
        const categoryEntity = CategoryEntity(
          title: title,
          alias: alias,
        );

        expect(categoryEntity.title, title);
        expect(categoryEntity.alias, alias);
      });

      test(
        'should support value equality',
        () {
          const categoryEntity1 = CategoryEntity(
            title: 'Italian',
            alias: 'italian',
          );
          const categoryEntity2 = CategoryEntity(
            title: 'Italian',
            alias: 'italian',
          );

          expect(
            categoryEntity1,
            equals(
              categoryEntity2,
            ),
          );
        },
      );

      test('should not be equal when properties differ', () {
        const categoryEntity1 =
            CategoryEntity(title: 'Italian', alias: 'italian');
        const categoryEntity2 =
            CategoryEntity(title: 'Mexican', alias: 'mexican');

        expect(
          categoryEntity1,
          isNot(
            equals(
              categoryEntity2,
            ),
          ),
        );
      });
    },
  );
}
