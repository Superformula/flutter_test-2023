import 'package:superformula_flutter_test/widgets/restaurant_status_widget.dart';

class RestaurantResult {
  late int total;
  late List<Restaurant> restaurants = [];

  RestaurantResult({this.total = 0, this.restaurants = const []});

  RestaurantResult.fromJson(Map<String, dynamic> json) {
    total = json["total"];
    final List restaurantsList = json["business"];
    restaurants = restaurantsList.map((e) => Restaurant.fromJson(e)).toList();
  }
}

class Restaurant {
  late String? id;
  late String? name;
  late String? price;
  late double? rating;
  late List<String>? photos;
  late List<Review>? reviews;
  late List<Category>? categories;
  late List<Hours>? hours;
  late Location? location;

  Restaurant.empty({this.id, this.name, this.price, this.rating, this.photos, this.categories, this.hours, this.reviews, this.location});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    price = json["price"];
    rating = json["rating"];
    final List photosList = json["photos"];
    photos = photosList.cast<String>();
    final List reviewsList = json["reviews"];
    reviews = reviewsList.map((e) => Review.fromJson(e)).toList();
    final List categoriesList = json["categories"];
    categories = categoriesList.map((e) => Category.fromJson(e)).toList();
    final List hoursList = json["hours"];
    hours = hoursList.map((e) => Hours.fromJson(e)).toList();
    location = Location.fromJson(json["location"]);
  }
}

class Category {
  late String? alias;
  late String? title;

  Category({this.alias, this.title});

  Category.fromJson(Map<String, dynamic> json) {
    alias = json["alias"];
    title = json["title"];
  }
}

class Hours {
  late bool? isOpenNow;
  late RestaurantStatus restaurantStatus;

  Hours({this.isOpenNow});

  Hours.fromJson(Map<String, dynamic> json) {
    isOpenNow = json["is_open_now"];
    restaurantStatus = (isOpenNow ?? false) ? RestaurantStatus.open : RestaurantStatus.closed;
  }
}

class Review {
  late String? id;
  late int? rating;
  late User? user;

  Review({this.id, this.rating, this.user});

  Review.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    rating = json["rating"];
    user = User.fromJson(json["user"]);
  }
}

class User {
  late String? id;
  late String? imageUrl;
  late String? name;

  User({this.id, this.imageUrl, this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    imageUrl = json["image_url"];
    name = json["name"];
  }
}

class Location {
  late String? formattedAddress;

  Location({this.formattedAddress});

  Location.fromJson(Map<String, dynamic> json) {
    formattedAddress = json["formatted_address"];
  }
}
