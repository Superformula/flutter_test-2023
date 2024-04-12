import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantour/providers/data_provider.dart';

class RestaurantsListWidget extends StatefulWidget {
  bool favorites;
  RestaurantsListWidget({this.favorites = false});

  @override
  State<RestaurantsListWidget> createState() => _RestaurantsListWidgetState();
}

class _RestaurantsListWidgetState extends State<RestaurantsListWidget> {
  DataProvider dataProvider = DataProvider();
  bool _isLoading = false;

  Future<void> getInitData() async {
    setState(() {
      _isLoading = true;
    });

    var result = await dataProvider.getRestaurants();

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result),
        backgroundColor: Theme.of(context).colorScheme.error,
      ));
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    dataProvider = Provider.of<DataProvider>(
      context,
      listen: false,
    );
    getInitData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator.adaptive()
              : Container(),
        ),
      ),
    );
  }
}
