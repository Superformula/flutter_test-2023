import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/domain/entities/hour_entity.dart';

void main() {
  group(
    'HourEntity',
    () {
      test('should have isOpenNow property correctly assigned', () {
        const isOpenNow = true;
        const hourEntity = HourEntity(isOpenNow: isOpenNow);

        expect(hourEntity.isOpenNow, isOpenNow);
      });

      test('should support value equality based on isOpenNow', () {
        const hourEntity1 = HourEntity(isOpenNow: true);
        const hourEntity2 = HourEntity(isOpenNow: true);

        expect(
          hourEntity1,
          equals(
            hourEntity2,
          ),
        );
      });

      test('should not be equal when isOpenNow values differ', () {
        const hourEntity1 = HourEntity(isOpenNow: true);
        const hourEntity2 = HourEntity(isOpenNow: false);

        expect(
          hourEntity1,
          isNot(
            equals(
              hourEntity2,
            ),
          ),
        );
      });
    },
  );
}
