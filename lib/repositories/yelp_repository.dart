import 'package:restaurantour/models/models.dart';
import 'package:restaurantour/services/services.dart';

class YelpRepository {
  final YelpService service;

  const YelpRepository({required this.service});

  /// Returns a response in this shape
  /// {
  /// "data": {
  ///   "search": {
  ///     "total": 5056,
  ///     "business": [
  ///       {
  ///         "id": "faPVqws-x-5k2CQKDNtHxw",
  ///         "name": "Yardbird Southern Table & Bar",
  ///         "price": "$$",
  ///         "rating": 4.5,
  ///         "photos": [
  ///           "https:///s3-media4.fl.yelpcdn.com/bphoto/_zXRdYX4r1OBfF86xKMbDw/o.jpg"
  ///         ],
  ///         "reviews": [
  ///           {
  ///             "id": "sjZoO8wcK1NeGJFDk5i82Q",
  ///             "rating": 5,
  ///             "user": {
  ///               "id": "BuBCkWFNT_O2dbSnBZvpoQ",
  ///               "image_url": "https:///s3-media2.fl.yelpcdn.com/photo/v8tbTjYaFvkzh1d7iE-pcQ/o.jpg",
  ///               "name": "Gina T."
  ///             }
  ///           },
  ///           {
  ///             "id": "okpO9hfpxQXssbTZTKq9hA",
  ///             "rating": 5,
  ///             "user": {
  ///               "id": "0x9xu_b0Ct_6hG6jaxpztw",
  ///               "image_url": "https:///s3-media3.fl.yelpcdn.com/photo/gjz8X6tqE3e4praK4HfCiA/o.jpg",
  ///               "name": "Crystal L."
  ///             }
  ///           },
  ///        ...
  ///     ]
  ///   }
  /// }
  Future<List<Restaurant>> getRestaurants({int offset = 0}) async {
    final response = await service.getRestaurants(offset: offset);
    return response.restaurants ?? [];
  }
}
