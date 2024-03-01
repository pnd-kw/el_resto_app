import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:retaste_app/bloc/cubit/cubit/check_connection_cubit.dart';
import 'package:retaste_app/bloc/restaurant_bloc.dart';
import 'package:retaste_app/utils/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:retaste_app/widget/check_connection_alert.dart';
import 'package:retaste_app/widget/restaurant_list_item_primary.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  late CheckConnectionCubit _checkConnectionCubit;
  late RestaurantBloc _restaurantBloc;

  @override
  void initState() {
    super.initState();
    _checkConnectionCubit = BlocProvider.of<CheckConnectionCubit>(context);
    _restaurantBloc = BlocProvider.of<RestaurantBloc>(context);

    _checkConnectionCubit.checkConnection();

    _restaurantBloc.add(FetchRestaurant());
  }

  void showCheckConnection() async {
    showDialog(
      context: context,
      builder: (context) => CheckConnectionAlert(
        onPressed: () async {
          Navigator.of(context).pop();

          bool isConnected = await _checkConnectionCubit.checkConnection();

          if (!isConnected) {
            showCheckConnection();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final defaultSize =
        DefaultSize(screenWidth: screenWidth, screenHeight: screenHeight);

    double circularProgressIndicatorHeight =
        defaultSize.circularProgressIndicatorHeight!;

    if (ResponsiveBreakpoints.of(context).largerThan(MOBILE)) {
      circularProgressIndicatorHeight = screenHeight / 10;
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
            child: BlocBuilder<CheckConnectionCubit, CheckConnectionState>(
              builder: (context, connectionState) {
                if (connectionState is Disconnected) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showCheckConnection();
                  });
                } else if (connectionState is Connected) {
                  return BlocConsumer<RestaurantBloc, RestaurantState>(
                    listenWhen: (previous, current) =>
                        current is RestaurantActionState,
                    buildWhen: (previous, current) =>
                        current is RestaurantLoading ||
                        current is RestaurantLoaded,
                    listener: (context, state) {
                      if (state is RestaurantNavigatorActionState) {
                        String restaurantId = state.id;
                        Navigator.of(context).pushNamed(
                            '/restaurant-detail-screen',
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
                                String restaurantId =
                                    state.restaurants[index].id;
                                _restaurantBloc.add(
                                    RestaurantNavigatorActionEvent(
                                        restaurantId));
                              },
                              child: RestaurantListItemPrimary(
                                restaurantId: state.restaurants[index].id,
                                name: state.restaurants[index].name,
                                description:
                                    state.restaurants[index].description,
                                image: state.restaurants[index].pictureId,
                                city: state.restaurants[index].city,
                                rating: state.restaurants[index].rating,
                              ),
                            );
                          },
                        );
                      } else if (state is RestaurantError) {
                        return SizedBox(
                            height: screenHeight,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    state.errorMessage,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    onPressed: () {
                                      _restaurantBloc.add(FetchRestaurant());
                                    },
                                    child: Text(
                                      'Reload',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      } else {
                        return SizedBox(
                          height: screenHeight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Connection interrupted, please reload',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: () {
                                  _restaurantBloc.add(FetchRestaurant());
                                },
                                child: Text(
                                  'Reload',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  );
                }
                return Center(
                  child: Center(
                    child: Text(
                      'Unknown state',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
