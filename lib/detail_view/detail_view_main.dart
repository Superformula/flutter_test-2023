import 'package:flutter/material.dart';
import 'package:restaurantour/common_widgets/is_open.dart';
import 'package:restaurantour/detail_view/review_row_item.dart';
import 'package:restaurantour/detail_view/review_row_item_loading.dart';
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
                        child:
                        snapshot.hasData ?
                        Image.network(
                          widget.restaurant.photos!.first,
                          fit: BoxFit.fill,
                        ) :
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [
                                  0.2,
                                  0.4,
                                  0.6,
                                  1.0,
                                ],
                                colors: [
                                  AppColor.gradientBG,
                                  AppColor.placeHolder,
                                  AppColor.placeHolder,
                                  AppColor.gradientBG,
                                ],
                              )
                          ),
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
                        return Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
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

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Address", style: widget.theme.textTheme.caption,),
                                  Padding(
                                    padding: const EdgeInsets.only(top:24.0),
                                    child: snapshot.hasData ? Text(widget.restaurant.location!.formattedAddress != null ? widget.restaurant.location!.formattedAddress! : "102 Lakeside Ave\nSeattle, WA 98122", style: widget.theme.textTheme.button,) :
                                    Column(
                                      children: [
                                        Container(
                                          width: 163,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.0),
                                            color: AppColor.placeHolder,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top:8.0),
                                          child: Container(
                                            width: 163,
                                            height: 22,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.0),
                                              color: AppColor.placeHolder,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  divider(),
                                ],
                              ),

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

                              Text("${widget.restaurant.reviews?.length ?? 0} Reviews", style: widget.theme.textTheme.caption,),
                              snapshot.hasData ?
                              widget.restaurant.reviews != null ?
                              Column(
                                  children: widget.restaurant.reviews!.asMap().entries.map((entry) {
                                    return ReviewRowItem(widget.theme, entry.value, entry.key, entry.key == widget.restaurant.reviews!.length-1);
                                  }).toList()
                              ) :
                              Container() :
                              Column(
                                  children: ["123","123","123"].asMap().entries.map((entry) {
                                    return ReviewRowItemLoading(entry.key == 2);
                                  }).toList()
                              )
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

  divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Divider(color: AppColor.dividerLine,thickness: 1),
    );
  }
}
