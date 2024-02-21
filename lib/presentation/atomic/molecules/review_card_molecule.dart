part of 'package.dart';

class ReviewCardMolecule extends StatelessWidget {
  final Review review;
  const ReviewCardMolecule({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RatingMolecule(rating: review.rating! * 1.0),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Review text goes here. Review text goes here. This is a review. This is a review that is 3 lines long.",
            ),
          ),
          Row(
            children: [
              CircleAvatarAtom(
                radius: 40,
                url: review.user!.imageUrl!,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(review.user!.name!),
            ],
          ),
        ],
      ),
    );
  }
}
