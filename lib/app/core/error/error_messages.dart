abstract class ErrorMessages {
  static const noInternetConnection = 'Unable to establish an internet connection';
  static const serverException = 'Oops! We had an internal problem. Try again!';
  static const noRestaurantData = 'No restaurant data saved.';

  static String noDataForRestaurantId(String id) =>
      'No restaurant data saved for this restaurant id ($id).';
}
