part of 'package.dart';

class DetailViewPage extends StatefulWidget {
  const DetailViewPage({super.key});

  @override
  State<DetailViewPage> createState() => _DetailViewPageState();
}

class _DetailViewPageState extends State<DetailViewPage> {
  Restaurant? restaurant;

  Future<void> fetchRestaurant() async {
    final restaurantId =
        context.read<ListRestaurantsProvider>().selectedRestaurantId!;
    final yelpRepo = YelpRepository();
    final result = await yelpRepo.getRestaurantDetail(id: restaurantId);
    restaurant = result;
    setState(() {});
  }

  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          restaurant?.name ?? "",
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: fetchRestaurant(),
        builder: (context, snapshot) {
          if (restaurant != null) {
            return ListView(
              controller: _controller,
              children: [
                AspectRatio(
                  aspectRatio: 2 / 3,
                  child: Image.network(
                    restaurant!.heroImage,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      _getBottomInformation(),
                      _divider(),
                      _address(),
                      // const Divider(),
                      _divider(),

                      _rating(),
                      _divider(),
                      _reviews(),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  _reviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${restaurant!.reviews!.length} reviews'),
        ...restaurant!.reviews!.map((e) => ReviewCardMolecule(review: e))
      ],
    );
  }

  _star() {
    return const Icon(
      Icons.star,
      size: 15,
      color: Colors.yellow,
    );
  }

  Widget _rating() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overall Rating',
            textAlign: TextAlign.start,
          ),
          if (restaurant!.rating != null)
            Row(
              children: [
                Text(
                  restaurant!.rating.toString(),
                  style: const TextStyle(fontSize: 30),
                ),
                _star(),
              ],
            ),
        ],
      );

  Widget _address() => Column(
        children: [
          const Text('Address'),
          if (restaurant!.location?.formattedAddress != null)
            Text(restaurant!.location!.formattedAddress!),
        ],
      );

  Divider _divider() => const Divider(
        height: 50,
      );

  Widget _getBottomInformation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          restaurant!.price!,
        ),
        Row(
          children: [
            Text(
              restaurant!.isOpen ? 'Open now' : 'Closed',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            Container(
              height: 10,
              width: 10,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: restaurant!.isOpen ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
