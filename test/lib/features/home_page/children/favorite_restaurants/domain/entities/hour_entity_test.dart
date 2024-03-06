import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'HourEntity',
    () {
      test(
        'should have isOpenNow property correctly assigned',
        () {
          const hourEntity = (isOpenNow: true,);
          expect(hourEntity.isOpenNow, true);
        },
      );

      test(
        'should support value equality based on isOpenNow',
        () {
          const hourEntity1 = (isOpenNow: true,);
          const hourEntity2 = (isOpenNow: true,);

          expect(
            hourEntity1,
            equals(
              hourEntity2,
            ),
          );
        },
      );

      test('should not be equal when isOpenNow values differ', () {
        const hourEntity1 = (isOpenNow: true,);
        const hourEntity2 = (isOpenNow: false,);

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
