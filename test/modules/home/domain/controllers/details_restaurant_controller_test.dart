import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restaurantour/core/enums/status_type_enum.dart';
import 'package:restaurantour/modules/home/data/models/response_model.dart';
import 'package:restaurantour/modules/home/data/models/restaurant.dart';
import 'package:restaurantour/modules/home/domain/controllers/details_restaurant_controller.dart';
import 'package:restaurantour/modules/home/domain/errors/erros.dart';
import 'package:restaurantour/modules/home/domain/repositories/restaurant_repository_interface.dart';

import '../../../../mocks/class_mocks.dart';

void main() {
  late IRestaurantRepository restaurantRepository;
  late DetailsRestaurantController detailsRestaurantController;

  setUp(() {
    restaurantRepository = ResturantRepositoryMock();
    detailsRestaurantController = DetailsRestaurantController(restaurantRepository);
  });

  group('[GET RESTAURANT BY ID]', () {
    test('should return a restaurant', () async {
      //Arrange
      const Restaurant restaurantMock = Restaurant(id: 'test_id', name: 'Test Name');
      when(() => restaurantRepository.getRestaurantById(id: any(named: 'id')))
          .thenAnswer((_) => Future.value(ResponseModel(data: restaurantMock)));

      //Act
      await detailsRestaurantController.loadRestaurant(Restaurant(id: restaurantMock.id));

      //Assert
      expect(detailsRestaurantController.status, StatusType.success);
      expect(detailsRestaurantController.restaurant.name!.isNotEmpty, true);
      expect(detailsRestaurantController.restaurant.name, restaurantMock.name);
      verify(() => restaurantRepository.getRestaurantById(id: any(named: 'id'))).called(1);
    });

    test('should return a exception when was not found restaurant', () async {
      //Arrange
      const Restaurant restaurantMock = Restaurant(id: 'test_id', name: 'Test Name');
      when(() => restaurantRepository.getRestaurantById(id: any(named: 'id')))
          .thenAnswer((_) => Future.value(ResponseModel(error: NotFoundRestaurant())));

      //Act
      await detailsRestaurantController.loadRestaurant(Restaurant(id: restaurantMock.id));

      //Assert
      expect(detailsRestaurantController.status, StatusType.failure);
      verify(() => restaurantRepository.getRestaurantById(id: any(named: 'id'))).called(1);
    });
  });
}
