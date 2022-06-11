
import 'package:flutter/material.dart';
import 'package:restaurantour/list_view/restaurant_list.dart';
import 'package:restaurantour/theme/app_color.dart';

class ListViewMain extends StatefulWidget {
  const ListViewMain({Key? key}) : super(key: key);

  @override
  State<ListViewMain> createState() => _ListViewMainState();
}

class _ListViewMainState extends State<ListViewMain> with TickerProviderStateMixin {
  late TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    _controller = TabController(length: 2,vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          // TODO: Need to check the size again.
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(size.height * 0.05),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.14),
              child: TabBar(
                controller: _controller,
                tabs: [
                  tabItem(theme,"All Restaurants",0),
                  tabItem(theme,"My Favorites",1)
                ],
              ),
            ),
          ),
          title: Text('RestauranTour', style: theme.textTheme.headline6,),
          toolbarHeight: size.height * 0.082,
        ),
      body: TabBarView(
        controller: _controller,
        children: [
          RestaurantList(theme),
          Icon(Icons.directions_bike),
        ],
      ),
    );
  }

  Tab tabItem(ThemeData theme, String text, int index) {
    return Tab(child: Text(text,
      style: theme.textTheme.button!.copyWith(
          color: _selectedIndex == index ? AppColor.defaultText : AppColor.secondaryText),),);
  }
}
