import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retaste_app/bloc/restaurant_bloc.dart';
import 'package:retaste_app/utils/layout/default_layout.dart';
import 'package:retaste_app/widget/restaurant_detail_screen_widgets/customer_review_item.dart';
import 'package:retaste_app/widget/restaurant_detail_screen_widgets/menu.dart';
import 'package:retaste_app/widget/restaurant_detail_screen_widgets/restaurant_detail_info.dart';
import 'package:retaste_app/widget/restaurant_detail_screen_widgets/restaurant_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class RestaurantDetailScreen extends StatefulWidget {
  const RestaurantDetailScreen({super.key});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  String restaurantId = '';
  late RestaurantBloc _restaurantBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final String? id = ModalRoute.of(context)!.settings.arguments as String?;
    if (id != null && id.isNotEmpty) {
      setState(() {
        restaurantId = id;
      });

      _restaurantBloc = BlocProvider.of<RestaurantBloc>(context);
      _restaurantBloc.add(FetchRestaurantDetail(id: id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final defaultSize =
        DefaultSize(screenWidth: screenWidth, screenHeight: screenHeight);

    double circularProgressIndicatorHeight =
        defaultSize.circularProgressIndicatorHeight!;
    double expandedHeight = defaultSize.expandedHeight!;

    if (ResponsiveBreakpoints.of(context).largerThan(MOBILE)) {
      circularProgressIndicatorHeight = screenHeight / 10;
      expandedHeight = screenHeight / 1.5;
    }

    return Scaffold(
      body: BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) {
          if (state is RestaurantDetailLoading) {
            return Center(
              child: SizedBox(
                height: circularProgressIndicatorHeight,
                child: const CircularProgressIndicator(),
              ),
            );
          } else if (state is RestaurantDetailLoaded) {
            final String image = state.restaurantDetail.pictureId;
            final String name = state.restaurantDetail.name;
            final List<String> categoryName = state.restaurantDetail.categories
                .map((category) => category.name)
                .toList();
            final double rating = state.restaurantDetail.rating;
            final String description = state.restaurantDetail.description;
            final String city = state.restaurantDetail.city;
            final String address = state.restaurantDetail.address;

            return Container(
              color: Colors.grey.shade200,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        height: screenHeight / 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade100,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    expandedHeight: expandedHeight,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Hero(
                          tag: 'restaurantImage_$restaurantId',
                          child: Image.network(
                            'https://restaurant-api.dicoding.dev/images/medium/$image',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        RestaurantDetailInfo(
                          name: name,
                          rating: rating,
                          description: description,
                          city: city,
                          address: address,
                          categoryName: categoryName,
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Menu(
                      title: 'Foods',
                      itemCount: state.restaurantDetail.menus.foods.length,
                      itemBuilder: (context, index) => RestaurantMenuItem(
                          menuTitle:
                              state.restaurantDetail.menus.foods[index].name),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Menu(
                      title: 'Drinks',
                      itemCount: state.restaurantDetail.menus.drinks.length,
                      itemBuilder: (context, index) => RestaurantMenuItem(
                          menuTitle:
                              state.restaurantDetail.menus.drinks[index].name),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Customer Reviews',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        ),
                      ),
                    ),
                  ),
                  SliverList.builder(
                    itemCount: state.restaurantDetail.customerReviews.length,
                    itemBuilder: (context, index) {
                      return CustomerReviewItem(
                          name: state
                              .restaurantDetail.customerReviews[index].name,
                          date: state
                              .restaurantDetail.customerReviews[index].date,
                          review: state
                              .restaurantDetail.customerReviews[index].review);
                    },
                  ),
                ],
              ),
            );
          } else if (state is RestaurantDetailError) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
            return const Center(
              child: Text('Unknown State'),
            );
          }
        },
      ),
    );
  }
}

// Widget buildMenu(BuildContext context, String title, int itemCount,
//         Widget Function(BuildContext, int) itemBuilder) =>
//     Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//           child: SizedBox(
//             width: double.infinity,
//             child: Text(
//               title,
//               style: Theme.of(context)
//                   .textTheme
//                   .titleLarge!
//                   .copyWith(color: Theme.of(context).colorScheme.onBackground),
//             ),
//           ),
//         ),
//         SizedBox(
//           width: double.infinity,
//           height: 200,
//           child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: itemCount,
//               itemBuilder: itemBuilder),
//         ),
//       ],
//     );
