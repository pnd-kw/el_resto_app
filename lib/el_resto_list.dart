import 'package:el_resto_app/restaurant_data.dart';
import 'package:el_resto_app/widget/el_resto_list_item.dart';
import 'package:flutter/material.dart';

class ElRestoList extends StatelessWidget {
  const ElRestoList({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final RestaurantData restaurantData = RestaurantData();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'El Resto',
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
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data['restaurants'].length,
                    itemBuilder: (context, index) {
                      var restaurant = snapshot.data['restaurants'][index];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/el-resto-detail',
                              arguments: restaurant);
                        },
                        child: ElRestoListItem(
                            name: restaurant['name'],
                            description: restaurant['description'],
                            image: restaurant['pictureId'],
                            city: restaurant['city'],
                            rating: restaurant['rating'].toDouble()),
                      );
                    },
                  );
                } else {
                  return const Text('No data available');
                }
              }),
        ),
      ),
    );
  }
}
