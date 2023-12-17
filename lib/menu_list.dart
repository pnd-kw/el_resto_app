import 'package:el_resto_app/model/menu_category.dart';
import 'package:el_resto_app/model/menu_category_list.dart';
import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  final String idResto;

  const MenuList({
    super.key,
    required this.idResto,
  });

  @override
  Widget build(BuildContext context) {
    // List<MenuCategory> filteredCategories =
    //     menuCategory.where((category) => category.restoId == idResto).toList();

    return ListView.builder(
      // itemCount: filteredCategories.length,
      itemBuilder: (context, index) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 20,
              right: 20,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Argentinian-style',
                    // filteredCategories[index].title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'PIZZA',
                    // filteredCategories[index].subtitle ?? '',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: ListView.builder(
              // itemCount: menuCategory[index].menuItems.length,
              itemBuilder: (context, menuIndex) => Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'NAPOLITANA',
                          // filteredCategories[index].menuItems[menuIndex].name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        ),
                        Text(
                          'IDR 150',
                          // filteredCategories[index]
                          //     .menuItems[menuIndex]
                          //     .price
                          //     .toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tomatoes, oreganos, green olives',
                        // filteredCategories[index]
                        //         .menuItems[menuIndex]
                        //         .description ??
                        //     '',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
