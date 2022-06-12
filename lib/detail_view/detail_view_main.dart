import 'package:flutter/material.dart';
import 'package:restaurantour/models/restaurant.dart';
import 'package:restaurantour/theme/app_color.dart';

class DetailViewMain extends StatefulWidget {
  final ThemeData theme;
  final Restaurant restaurant;
  final int index;

  DetailViewMain(this.theme, this.restaurant,
      this.index); // const DetailViewMain({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 320.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.restaurant.name ?? "", style: widget.theme.textTheme.headline6!.copyWith(
                color: isShrink ? AppColor.primaryFill : AppColor.surface
              )),
              titlePadding: isShrink ? null : EdgeInsets.fromLTRB(24, 0, 24, 16),
              background: Hero(
                tag: "restaurantPhoto${widget.index}",
                child: Image.network(
                  widget.restaurant.photos!.first,
                  fit: BoxFit.fill,
                ),
              ),
              centerTitle: false,
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: isShrink ? AppColor.primaryFill : AppColor.surface),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.favorite_border, color: isShrink ? AppColor.primaryFill : AppColor.surface),
                tooltip: 'Open shopping cart',
                onPressed: () {
                  // handle the press
                },
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Text(widget.restaurant.price ?? ""),
                      ],
                    )
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      )
    );
  }
}
