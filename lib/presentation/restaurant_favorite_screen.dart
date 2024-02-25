import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retaste_app/bloc/cubit/cubit/favorite_restaurant_cubit.dart';
import 'package:retaste_app/utils/layout/default_layout.dart';
import 'package:retaste_app/widget/restaurant_search_result_screen_widgets/restaurant_search_list_item.dart';

class RestaurantFavoriteScreen extends StatefulWidget {
  const RestaurantFavoriteScreen({super.key});

  @override
  State<RestaurantFavoriteScreen> createState() =>
      _RestaurantFavoriteScreenState();
}

class _RestaurantFavoriteScreenState extends State<RestaurantFavoriteScreen> {
  late FavoriteRestaurantCubit _favoriteRestaurantCubit;

  @override
  void initState() {
    _favoriteRestaurantCubit = context.read<FavoriteRestaurantCubit>();

    _favoriteRestaurantCubit.loadFavoriteRestaurants();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final defaultSize = DefaultSize(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      bgImgHeight: screenHeight / 5,
    );

    double circularProgressIndicatorHeight =
        defaultSize.circularProgressIndicatorHeight!;
    double bgImgHeight = defaultSize.bgImgHeight!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Restaurant',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child:
                BlocConsumer<FavoriteRestaurantCubit, FavoriteRestaurantState>(
              listenWhen: (previous, current) =>
                  current is FavoriteRestaurantActionState,
              buildWhen: (previous, current) =>
                  current is FavoriteRestaurantEmpty ||
                  current is FavoriteRestaurantLoaded,
              listener: (context, state) {
                if (state is NavigatorActionState) {
                  String restaurantId = state.id;
                  Navigator.of(context).pushNamed('/restaurant-detail-screen',
                      arguments: restaurantId);
                }
              },
              builder: (context, state) {
                if (state is FavoriteRestaurantInitial) {
                  return Center(
                    child: SizedBox(
                      height: circularProgressIndicatorHeight,
                      child: const CircularProgressIndicator(),
                    ),
                  );
                } else if (state is FavoriteRestaurantEmpty) {
                  return SizedBox(
                    height: screenHeight,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: bgImgHeight,
                            child: Image.asset(
                              'assets/images/search-placeholder.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight / 12,
                            child: Text(
                              'Oops favorite restaurant is empty, start adding some....',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else if (state is FavoriteRestaurantLoaded) {
                  return ListView.builder(
                      itemCount: state.restaurants.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            String restaurantId = state.restaurants[index].id;
                            context
                                .read<FavoriteRestaurantCubit>()
                                .navigateToRestaurantDetail(restaurantId);
                          },
                          child: RestaurantSearchListItem(
                            restaurantId: state.restaurants[index].id,
                            name: state.restaurants[index].name,
                            description: state.restaurants[index].description,
                            image: state.restaurants[index].pictureId,
                            city: state.restaurants[index].city,
                            rating: state.restaurants[index].rating,
                          ),
                        );
                      });
                } else if (state is FavoriteRestaurantError) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                } else {
                  return Center(
                      child: Text(
                    'Unknown state',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                    textAlign: TextAlign.center,
                  ));
                }
              },
            ),
          )),
    );
  }
}
