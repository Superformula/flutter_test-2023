import 'package:restaurantour/features/restaurant/domain/models/restaurant.dart';

Restaurant restaurantMockup = Restaurant(
  id: '1',
  name: 'Gordon Ramsay Hell\'s Kitchen',
  price: '\$\$\$',
  rating: 4.5,
  photos: [
    'https://s3-media2.fl.yelpcdn.com/bphoto/q771KjLzI5y638leJsnJnQ/o.jpg',
  ],
  categories: [
    Category(alias: 'newamerican', title: 'New American'),
  ],
  hours: [const Hours(isOpenNow: true)],
  reviews: [
    const Review(
      id: '1',
      rating: 5,
      user: User(
        id: '1',
        imageUrl: 'https://s3-media2.fl.yelpcdn.com/photo/1.jpg',
        name: 'John Doe',
      ),
    ),
  ],
  location: Location(formattedAddress: '123 Example St, City'),
);
