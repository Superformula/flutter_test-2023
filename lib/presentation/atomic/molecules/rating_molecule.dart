part of 'package.dart';

class RatingMolecule extends StatelessWidget {
  final int starCount;
  final double rating;
  final double starSize;
  const RatingMolecule({
    super.key,
    required this.rating,
    this.starSize = 15,
    this.starCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        starCount,
        (index) => buildStar(context, index),
      ),
    );
  }

  Widget buildStar(BuildContext context, int index) {
    IconData icon;
    if (index >= rating) {
      // icon = Icons.star_border;
      return const SizedBox();
    } else if (index > rating - 1 && index < rating) {
      icon = Icons.star_half;
    } else {
      icon = Icons.star;
    }
    return _icon(icon);
  }

  _icon(IconData icon) {
    return Icon(
      icon,
      size: starSize,
      color: Colors.yellow,
    );
  }
}
