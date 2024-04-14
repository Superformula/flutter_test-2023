import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurantour/helpers/favorites_helper.dart';
import 'package:restaurantour/models/restaurant.dart';

class RestaurantCardWidget extends StatefulWidget {
  final Restaurant restaurant;
  final bool favorite;
  const RestaurantCardWidget({
    super.key,
    required this.restaurant,
    required this.favorite,
  });

  @override
  State<RestaurantCardWidget> createState() => _RestaurantCardWidgetState();
}

class _RestaurantCardWidgetState extends State<RestaurantCardWidget> {
  late bool _isFavorite;

  @override
  void initState() {
    setState(() {
      _isFavorite = !widget.favorite;
    });
    print("Isfavorite: ${_isFavorite}");
    super.initState();
  }

  Future<void> changeFavorite() async {
    print(_isFavorite);

    await FavoritesHelpers().addFavorite(widget.restaurant.id ?? "");
    setState(() {
      _isFavorite != _isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        alignment: Alignment.centerLeft,
        height: size.height * 0.135,
        width: size.width * 0.95,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.restaurant.heroImage,
                  fit: BoxFit.cover,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              width: size.width * 0.28,
              height: size.height * 0.15,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 10,
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          // height: size.height * 0.05,
                          child: Text(
                            widget.restaurant.name ?? "",
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        Text(
                          "${widget.restaurant.price} ${widget.restaurant.displayCategory}",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(
                                      widget.restaurant.rating!.toInt(),
                                      (index) => Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 15,
                                          )).toList(),
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      widget.restaurant.isOpen
                                          ? "Open now"
                                          : " Closed",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontStyle: FontStyle.italic,
                                          ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        left: 5,
                                      ),
                                      child: Icon(
                                        Icons.circle,
                                        color: widget.restaurant.isOpen
                                            ? Colors.greenAccent
                                            : Colors.redAccent,
                                        size: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        right: 0,
                        child: GestureDetector(
                          onTap: () => changeFavorite(),
                          child: Icon(
                            Icons.favorite,
                            color: _isFavorite ? Colors.pink : Colors.grey,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
