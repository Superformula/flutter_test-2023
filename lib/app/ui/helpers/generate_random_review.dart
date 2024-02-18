import 'dart:math';

String generateRandomReview() {
  final random = Random();
  final reviews = [
    "The food was absolutely delicious! I highly recommend trying their pasta dishes. The service was great too.",
    "I had a wonderful experience at this restaurant. The ambiance was cozy and inviting. The staff was friendly and attentive.",
    "The restaurant had a great selection of wines. I enjoyed the steak, it was cooked perfectly. Will definitely be coming back!",
    "The dessert menu was impressive. I tried the chocolate lava cake and it was divine. Overall, a fantastic dining experience.",
  ];
  return reviews[random.nextInt(reviews.length)];
}
