import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/my_favorites/my_favorites_main.dart';
import 'package:restaurantour/repositories/local_db.dart';
import 'package:restaurantour/theme/app_color.dart';
import 'package:restaurantour/theme/app_theme.dart';

import '../repositories/key_collection.dart';

class DetailViewAppBar extends StatefulWidget {
  final Restaurant restaurant;
  final bool isShrink;
  final int index;
  final bool isLoading;

  const DetailViewAppBar(
      this.restaurant, this.isShrink, this.index, this.isLoading,
      {Key? key})
      : super(key: key);

  @override
  State<DetailViewAppBar> createState() => _DetailViewAppBarState();
}

class _DetailViewAppBarState extends State<DetailViewAppBar> {
  LocalDB db = LocalDB.instance;
  bool isFavorite = false;

  @override
  void initState() {
    initFavorite();
    super.initState();
  }

  initFavorite() async {
    // Check the restaurant is favorite or not.
    final checkFavorite = await db.isFavorite(widget.restaurant.id!);
    if (checkFavorite) {
      setState(() {
        isFavorite = checkFavorite;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      pinned: true,
      expandedHeight: 320.0,
      flexibleSpace: FlexibleSpaceBar(
        title: SizedBox(
          width: size.width * 0.7,
          child: Text(widget.restaurant.name ?? "",
              overflow: widget.isShrink ? TextOverflow.ellipsis : null,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: widget.isShrink
                      ? AppColor.primaryFill
                      : AppColor.surface)),
        ),
        titlePadding:
            widget.isShrink ? null : const EdgeInsets.fromLTRB(24, 0, 24, 16),
        background: Hero(
          tag: "${GlobalKeyName.imageHero}${widget.index}",
          child: widget.isLoading
              ? Image.network(
                  widget.restaurant.photos!.first,
                  fit: BoxFit.fill,
                )
              : Container(
                  decoration: AppTheme.gradientLoadingDecoration,
                ),
        ),
        centerTitle: false,
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back,
            color: widget.isShrink ? AppColor.primaryFill : AppColor.surface),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
              color: widget.isShrink ? AppColor.primaryFill : AppColor.surface),
          onPressed: () async {
            setState(() {
              isFavorite = !isFavorite;
            });
            db.saveFavorite(widget.restaurant.id!, isFavorite);
            // TODO: update favorite data in model view
          },
        ),
      ],
    );
  }
}
