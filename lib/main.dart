import 'package:flutter/material.dart';

import 'app.dart';
import 'repositories/yelp_repository.dart';

void main() {
  runApp(Restaurantour(yelpRepository: YelpRepository()));
}
