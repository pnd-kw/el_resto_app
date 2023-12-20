import 'package:el_resto_app/widget/el_resto_list_item.dart';
import 'package:flutter/material.dart';
import 'package:el_resto_app/model/resto_list.dart';

class ElRestoList extends StatelessWidget {
  const ElRestoList({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
          child: ListView.builder(
            itemCount: restoList.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed('/el-resto-detail', arguments: restoList[index]);
              },
              child: ElRestoListItem(
                  name: restoList[index].name,
                  image: restoList[index].image,
                  description: restoList[index].description,
                  rating: restoList[index].rating,
                  openHours: restoList[index].openHours),
            ),
          ),
        ),
      ),
    );
  }
}
