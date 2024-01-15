import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:retaste_app/bloc/restaurant_bloc.dart';
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

    final mobileCircularProgressIndicatorHeight = screenHeight / 20;

    double circularProgressIndicatorHeight = screenHeight / 10;

    if (ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE)) {
      circularProgressIndicatorHeight = mobileCircularProgressIndicatorHeight;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Retaste',
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        actions: [
          SizedBox(
            height: screenHeight / 12,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/restaurant-search-screen');
              },
              icon: const Icon(Icons.search),
            ),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        height: screenHeight,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: BlocConsumer<RestaurantBloc, RestaurantState>(
            listenWhen: (previous, current) => current is RestaurantActionState,
            buildWhen: (previous, current) =>
                current is RestaurantLoading || current is RestaurantLoaded,
            listener: (context, state) {
              if (state is RestaurantNavigatorActionState) {
                String restaurantId = state.id;
                Navigator.of(context).pushNamed('/restaurant-detail-screen',
                    arguments: restaurantId);
              }
            },
            builder: (context, state) {
              if (state is RestaurantLoading) {
                return Center(
                  child: SizedBox(
                    height: circularProgressIndicatorHeight,
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
                        _restaurantBloc
                            .add(RestaurantNavigatorActionEvent(restaurantId));
                      },
                      child: RestaurantListItem(
                        restaurantId: state.restaurants[index].id,
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
            },
          ),
        ),
      ),
    );
  }
}
