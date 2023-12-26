import 'package:retaste_app/model/retaurant.dart';
import 'package:retaste_app/repository/restaurant_data.dart';
import 'package:retaste_app/widget/restaurant_list_item.dart';
import 'package:flutter/material.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final RestaurantData restaurantData = RestaurantData();

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
          child: FutureBuilder(
            future: restaurantData.getRestaurantData(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Restaurant>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                List<Restaurant> restaurants = snapshot.data!;

                return ListView.builder(
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      var restaurant = restaurants[index];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/restaurant-detail',
                              arguments: restaurant);
                        },
                        child: RestaurantListItem(
                          name: restaurant.name,
                          description: restaurant.description,
                          image: restaurant.image,
                          city: restaurant.city,
                          rating: restaurant.rating,
                        ),
                      );
                    });
              } else {
                return const Text('No data available');
              }
            },
          ),
        ),
      ),
    );
  }
}
