import 'package:retaste_app/model/retaurant.dart';
import 'package:retaste_app/widget/restaurant_detail_info.dart';
import 'package:retaste_app/widget/restaurant_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class RestaurantDetail extends StatelessWidget {
  const RestaurantDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final Restaurant restaurant =
        ModalRoute.of(context)!.settings.arguments as Restaurant;

    final screenHeight = MediaQuery.of(context).size.height;

    final mobileExpandedHeight = screenHeight / 3;

    double expandedHeight = screenHeight / 1.5;

    if (ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE)) {
      expandedHeight = mobileExpandedHeight;
    }

    return Scaffold(
      body: Container(
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
                  child: Image.network(
                    restaurant.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  RestaurantDetailInfo(
                    name: restaurant.name,
                    rating: restaurant.rating,
                    description: restaurant.description,
                    city: restaurant.city,
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Foods',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: restaurant.foods.length,
                        itemBuilder: (context, index) => RestaurantMenuItem(
                            menuTitle: restaurant.foods[index])),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Drinks',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: restaurant.drinks.length,
                        itemBuilder: (context, index) => RestaurantMenuItem(
                            menuTitle: restaurant.drinks[index])),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
