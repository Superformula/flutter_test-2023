import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurantour/detail_view/detail_header_ingerited_widget.dart';
import 'package:restaurantour/detail_view/favorite_button.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/repositories/local_db.dart';
import 'package:restaurantour/theme/app_color.dart';
import 'package:restaurantour/theme/app_theme.dart';
import 'package:restaurantour/view_model/favorite_model.dart';

class DetailViewAppBar extends StatefulWidget {
  final FavoriteModel favoriteModel;
  final Restaurant restaurant;
  final bool isShrink;
  final String heroTag;

  const DetailViewAppBar(
      this.favoriteModel, this.restaurant, this.isShrink, this.heroTag,
      {Key? key})
      : super(key: key);

  static DetailViewAppBarState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DetailHeaderInheritedWidget>()!
        .data;
  }

  @override
  State<DetailViewAppBar> createState() => DetailViewAppBarState();
}

class DetailViewAppBarState extends State<DetailViewAppBar> {
  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  @override
  void initState() {
    super.initState();
    initFavorite();
  }

  initFavorite() async {
    // Check the restaurant is favorite or not.
    final checkFavorite =
        await LocalDB.instance.isFavorite(widget.restaurant.id!);
    if (checkFavorite) {
      setState(() {
        _isFavorite = checkFavorite;
      });
    }
  }

  setFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DetailHeaderInheritedWidget(
      data: this,
      child: SliverAppBar(
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
              tag: widget.heroTag,
              child: CachedNetworkImage(
                imageUrl: widget.restaurant.photos!.first,
                fit: BoxFit.fill,
                placeholder: (context, url) => Container(
                  decoration: AppTheme.gradientLoadingDecoration,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )),
          centerTitle: false,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: widget.isShrink ? AppColor.primaryFill : AppColor.surface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          FavoriteButton(
              favoriteModel: widget.favoriteModel,
              restaurantId: widget.restaurant.id!,
              isShrink: widget.isShrink),
        ],
      ),
    );
  }
}
