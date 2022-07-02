import 'package:flutter/material.dart';
import 'package:restaurantour/common_widgets/app_place_holder.dart';
import 'package:restaurantour/common_widgets/is_open.dart';
import 'package:restaurantour/detail_view/detail_view_app_bar.dart';
import 'package:restaurantour/detail_view/review_row_item.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/models/shared_const.dart';
import 'package:restaurantour/theme/app_color.dart';
import 'package:restaurantour/view_model/favorite_model.dart';

class DetailViewArgument {
  final FavoriteModel favoriteModel;
  final Restaurant restaurant;
  final String heroTag;

  DetailViewArgument(this.favoriteModel, this.restaurant, this.heroTag);
}

class DetailViewMain extends StatefulWidget {
  final FavoriteModel favoriteModel;
  final Restaurant restaurant;
  final String heroTag;

  const DetailViewMain(this.favoriteModel, this.restaurant, this.heroTag,
      {Key? key})
      : super(key: key);

  @override
  State<DetailViewMain> createState() => _DetailViewMainState();
}

class _DetailViewMainState extends State<DetailViewMain> {
  late ScrollController _scrollController;
  bool isShrink = false;

  _scrollListener() {
    setState(() {
      if (_scrollController.hasClients &&
          _scrollController.offset > (kNavigationBarHeight - kToolbarHeight)) {
        isShrink = true;
      } else {
        isShrink = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          DetailViewAppBar(widget.favoriteModel, widget.restaurant, isShrink,
              widget.heroTag),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      priceAndIsOpen(),
                      address(true),
                      overallRating(),
                      reviews(true)
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget reviews(bool hasData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.restaurant.reviews?.length ?? 0} Reviews",
          style: Theme.of(context).textTheme.caption,
        ),
        hasData
            ? Column(
                children:
                    widget.restaurant.reviews!.asMap().entries.map((entry) {
                return ReviewRowItem(
                    isLoading: false,
                    isLastComment:
                        entry.key == widget.restaurant.reviews!.length - 1,
                    theme: Theme.of(context),
                    review: entry.value,
                    index: entry.key);
              }).toList())
            : Column(// Review Place Holder
                children: const [
                ReviewRowItem(isLoading: true),
                ReviewRowItem(isLoading: true),
                ReviewRowItem(isLoading: true, isLastComment: true)
              ])
      ],
    );
  }

  Widget overallRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Overall Rating",
          style: Theme.of(context).textTheme.caption,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${widget.restaurant.rating ?? 5}",
                style: Theme.of(context).textTheme.headline4,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 0, 0, 6),
                child: Icon(
                  Icons.star,
                  color: AppColor.star,
                  size: 12,
                ),
              )
            ],
          ),
        ),
        divider(),
      ],
    );
  }

  Widget priceAndIsOpen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text("${widget.restaurant.price ?? ""}, "),
                Text(widget.restaurant.categories?.first.title ?? ""),
              ],
            ),
            IsOpen(Theme.of(context),
                widget.restaurant.hours!.first.isOpenNow ?? false)
          ],
        ),
        divider(),
      ],
    );
  }

  Widget address(bool hasData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Address",
          style: Theme.of(context).textTheme.caption,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: hasData
              ? Text(
                  widget.restaurant.location!.formattedAddress != null
                      ? widget.restaurant.location!.formattedAddress!
                      : "102 Lakeside Ave\nSeattle, WA 98122",
                  style: Theme.of(context).textTheme.button,
                )
              : Column(
                  children: const [
                    AppPlaceHolder(
                      height: 22,
                      width: 163,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: AppPlaceHolder(
                        height: 22,
                        width: 163,
                      ),
                    ),
                  ],
                ),
        ),
        divider(),
      ],
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Divider(color: AppColor.dividerLine, thickness: 1),
    );
  }
}
