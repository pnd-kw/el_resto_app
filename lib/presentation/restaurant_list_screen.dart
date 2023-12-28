import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retaste_app/bloc/restaurant_bloc.dart';
// import 'package:retaste_app/model/retaurant.dart';
// import 'package:retaste_app/repository/restaurant_data.dart';
import 'package:retaste_app/widget/restaurant_list_item.dart';
import 'package:flutter/material.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  late RestaurantBloc _restaurantBloc;

  @override
  void initState() {
    super.initState();
    _restaurantBloc = BlocProvider.of<RestaurantBloc>(context);
    _restaurantBloc.add(FetchRestaurant());
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final RestaurantData restaurantData = RestaurantData();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Retaste',
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: screenHeight,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: BlocBuilder<RestaurantBloc, RestaurantState>(
              builder: (context, state) {
            // final restaurantBloc = BlocProvider.of<RestaurantBloc>(context);

            if (state is RestaurantLoading) {
              return Center(
                child: SizedBox(
                  height: screenHeight / 20,
                  child: const CircularProgressIndicator(),
                ),
              );
            } else if (state is RestaurantLoaded) {
              return ListView.builder(
                itemCount: state.restaurants.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      String restaurantId = state.restaurants[index].id;
                      // _restaurantBloc
                      //     .add(FetchRestaurantDetail(id: restaurantId));
                      Navigator.of(context).pushNamed(
                          '/restaurant-detail-screen',
                          arguments: restaurantId);
                    },
                    child: RestaurantListItem(
                      name: state.restaurants[index].name,
                      description: state.restaurants[index].description,
                      image: state.restaurants[index].pictureId,
                      city: state.restaurants[index].city,
                      rating: state.restaurants[index].rating,
                    ),
                  );
                },
              );
            } else if (state is RestaurantError) {
              return Center(
                child: Text(state.errorMessage),
              );
            } else {
              return const Center(
                child: Text('Unknown state'),
              );
            }
          }),
          // child: FutureBuilder(
          //   future: restaurantData.getRestaurantData(),
          //   builder: (BuildContext context,
          //       AsyncSnapshot<List<Restaurant>> snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const CircularProgressIndicator();
          //     } else if (snapshot.hasError) {
          //       return Text('Error: ${snapshot.error}');
          //     } else if (snapshot.hasData) {
          //       List<Restaurant> restaurants = snapshot.data!;

          //       return ListView.builder(
          //           itemCount: restaurants.length,
          //           itemBuilder: (context, index) {
          //             var restaurant = restaurants[index];
          //             return InkWell(
          //               onTap: () {
          //                 Navigator.of(context).pushNamed('/restaurant-detail',
          //                     arguments: restaurant);
          //               },
          //               child: RestaurantListItem(
          //                 name: restaurant.name,
          //                 description: restaurant.description,
          //                 // image: restaurant.image,
          //                 city: restaurant.city,
          //                 rating: restaurant.rating,
          //               ),
          //             );
          //           });
          //     } else {
          //       return const Text('No data available');
          //     }
          //   },
          // ),
        ),
      ),
    );
  }
}
