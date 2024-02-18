import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/presentation/bloc/RestaurantsBloc.dart';
import 'package:restaurantour/presentation/bloc/restaurants_state.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RestauranTour'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<RestaurantsBloc,RestaurantsState>(
          builder: (context, state) {
            if (state is RestaurantsEmpty) {
              return Container();
            }
            if (state is RestaurantsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if( state is RestaurantsLoadFail){
              return const Center(
                key: Key('error'),
                child: Text('Error'),);
            }
            if(state is RestaurantsLoaded){
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.result.length,
                itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.result[index].name),
                );
              },);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
