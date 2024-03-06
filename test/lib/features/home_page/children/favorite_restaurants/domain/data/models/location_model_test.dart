import 'package:flutter_test/flutter_test.dart';
import 'package:restaurantour/features/home_page/children/favorite_restaurants/data/models/location_model.dart';

void main() {
  group('LocationModel', () {
    const formattedAddress = '123 Main St, Anytown, AT 12345';
    const jsonMap = {'formatted_address': formattedAddress};

    test('should return a valid model from JSON', () {
      final result = LocationModel.fromJson(jsonMap);

      expect(result, isA<LocationModel>());
      expect(result.formattedAddress, formattedAddress);
    });

    test('should return a JSON map containing the proper data', () {
      const model = LocationModel(formattedAddress: formattedAddress);
      final result = model.toJson();
      expect(result, jsonMap);
    });
  });
}
