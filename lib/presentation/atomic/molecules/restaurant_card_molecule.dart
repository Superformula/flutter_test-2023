part of 'package.dart';

class RestaurantCardMolecule extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantCardMolecule({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    // late double cardWidth;
    // late double height;
    // if (MediaQuery.of(context).size.width > 728) {
    //   height = MediaQuery.of(context).size.width * 0.15;
    //   cardWidth = MediaQuery.of(context).size.width * 0.2;
    // } else {
    //   height = 110;
    //   cardWidth = 120;
    // }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Container(
        height: 105,
        color: Colors.white,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageRoundedAtom(
              height: 88,
              width: 88,
              url: restaurant.heroImage,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(child: _getBottomInformation()),
          ],
        ),
      ),
    );
  }

  Widget _getBottomInformation() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(restaurant.name!, maxLines: 2),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '\$ ${restaurant.price!}',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingMolecule(
                  rating: restaurant.rating!,
                  starSize: 17,
                  starCount: 5,
                ),
                Row(
                  children: [
                    Text(
                      restaurant.isOpen ? 'Open now' : 'Closed',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                    Container(
                      height: 10,
                      width: 10,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: restaurant.isOpen ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
