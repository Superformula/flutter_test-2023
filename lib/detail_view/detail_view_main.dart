
import 'package:flutter/material.dart';
import 'package:restaurantour/common_widgets/app_place_holder.dart';
import 'package:restaurantour/common_widgets/is_open.dart';
import 'package:restaurantour/detail_view/detail_view_app_bar.dart';
import 'package:restaurantour/detail_view/review_row_item.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/my_favorites/my_favorites_main.dart';
import 'package:restaurantour/theme/app_color.dart';

class DetailViewMain extends StatefulWidget {
  final ThemeData theme;
  final Restaurant restaurant;
  final int index;
  final GlobalKey<MyFavoritesMainState> myFavoriteKey;

  const DetailViewMain(this.theme, this.restaurant, this.index,
      this.myFavoriteKey, {Key? key}) : super(key: key);

  @override
  State<DetailViewMain> createState() => _DetailViewMainState();
}

class _DetailViewMainState extends State<DetailViewMain> {
  late ScrollController _scrollController;
  bool isShrink = false;

  _scrollListener() {
    setState(() {
      if (_scrollController.hasClients &&
          _scrollController.offset > (320 - kToolbarHeight)) {
        isShrink = true;
      }else {
        isShrink = false;
      }
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  final Future<bool> _futureLoading = Future<bool>.delayed(
    const Duration(seconds: 2),
        () => true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: _futureLoading,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              DetailViewAppBar(widget.theme, widget.restaurant, isShrink, widget.index, snapshot.hasData, widget.myFavoriteKey),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          priceAndIsOpen(),
                          address(snapshot.hasData),
                          overallRating(),
                          reviews(snapshot.hasData)
                        ],
                      ),
                    );
                  },
                  childCount: 1,
                ),
              ),
            ],
          );
        }
      )
    );
  }

  Widget reviews(bool hasData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${widget.restaurant.reviews?.length ?? 0} Reviews", style: widget.theme.textTheme.caption,),
        hasData ?
        widget.restaurant.reviews != null ?
        Column(
            children: widget.restaurant.reviews!.asMap().entries.map((entry) {
              return ReviewRowItem(false, entry.key == widget.restaurant.reviews!.length-1,widget.theme, entry.value, entry.key);
            }).toList()
        ) :
        Container() :
        Column(
            children: const [
              ReviewRowItem(true),
              ReviewRowItem(true),
              ReviewRowItem(true,true)
            ]
        )
      ],
    );
  }

  Widget overallRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Overall Rating", style: widget.theme.textTheme.caption,),
        Padding(
          padding: const EdgeInsets.only(top:16.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("${widget.restaurant.rating ?? 5}", style: widget.theme.textTheme.headline4,),
              Padding(
                padding: const EdgeInsets.fromLTRB(2.0,0,0,6),
                child: Icon(Icons.star,color: AppColor.star,size: 12,),
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
            Text("${widget.restaurant.price ?? ""}, ${widget.restaurant.categories?.first.title ?? ""}"),
            IsOpen(widget.theme, widget.restaurant)
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
        Text("Address", style: widget.theme.textTheme.caption,),
        Padding(
          padding: const EdgeInsets.only(top:24.0),
          child: hasData ? Text(widget.restaurant.location!.formattedAddress != null ? widget.restaurant.location!.formattedAddress! : "102 Lakeside Ave\nSeattle, WA 98122", style: widget.theme.textTheme.button,) :
          Column(
            children: const [
              AppPlaceHolder(height: 22, width: 163,),
              Padding(
                padding: EdgeInsets.only(top:8.0),
                child: AppPlaceHolder(height: 22, width: 163,),
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
      child: Divider(color: AppColor.dividerLine,thickness: 1),
    );
  }
}
