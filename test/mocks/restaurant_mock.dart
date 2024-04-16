import 'package:restaurantour/data/models/restaurant_model.dart';
import 'package:restaurantour/domain/entities/entities.dart';

class RestaurantMock {
  static RestaurantModel get restarantModel => const RestaurantModel(
        idModel: '666',
        nameModel: 'Brazilian Food Restaurant',
        priceModel: '\$\$\$',
        ratingModel: 4,
        photosModel: ['https://www.google.com'],
        categoriesModel: [
          CategoryModel(
            aliasModel: 'Rice',
            titleModel: 'Rice and Beans',
          ),
        ],
        hoursModel: [
          HoursModel(isOpenNowModel: true),
        ],
        reviewsModel: [
          ReviewModel(
            idModel: '1234560',
            ratingModel: 5,
            userModel: UserModel(
              idModel: '78954',
              imageUrlModel: 'pixabay.com',
              nameModel: 'Cindy Lauper',
            ),
          ),
        ],
        locationModel: LocationModel(
          formattedAddressModel: '125 Apple Street',
        ),
      );

  static RestaurantEntity get restarantEntity => RestaurantEntity(
        id: restarantModel.idModel,
        name: restarantModel.nameModel,
        price: restarantModel.priceModel,
        rating: restarantModel.ratingModel,
        photos: restarantModel.photosModel,
        categories: restarantModel.categoriesModel,
        hours: restarantModel.hoursModel,
        reviews: restarantModel.reviewsModel,
        location: restarantModel.locationModel,
      );
}
