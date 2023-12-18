// import 'package:el_resto_app/model/menu_category.dart';
import 'package:el_resto_app/model/menu.dart';
import 'package:el_resto_app/model/menu_category_list.dart';
import 'package:el_resto_app/model/menu_list.dart';
import 'package:el_resto_app/model/resto.dart';
import 'package:el_resto_app/model/resto_menu_category_list.dart';
import 'package:flutter/material.dart';

class ElRestoDetail extends StatelessWidget {
  const ElRestoDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final resto = ModalRoute.of(context)!.settings.arguments as Resto;
    // Menginisialisasi Map dengan key value pair pertama berupa <restoId(String) berpasangan dengan <Map yang berisi key value pair berupa <menuCategoryId(String) berpasangan dengan List<Menu>>>
    Map<String, Map<String, List<Menu>>> menuItemsByRestoAndCategory = {};

    // Filter Menu Categories yang sesuai dengan Restoran tertentu
    final restoMenuCategories = menuCategoryList
        .where((category) => restoMenuCategoryList.any((relation) =>
            relation.restoId == resto.restoId &&
            relation.menuCategoryId == category.menuCategoryId))
        .toList();

    // Iterasi dilakukan pada setiap item dalam `restoMenuCategoryList`(daftar relasi antara restoran dan kategori menu), perulangan digunakan untuk mencari `Menu` yang memiliki `restoId` dan `menuCategoryId` yang sesuai dengan restoran yang dipilih oleh user dari seluruh list restoran
    for (var restoMenuCategory in restoMenuCategoryList) {
      final menu = menuList.where((menu) =>
          menu.restoId == restoMenuCategory.restoId &&
          menu.menuCategoryId == restoMenuCategory.menuCategoryId);

      // Memeriksa apakah `menuItemsByRestoAndCategory` sudah memiliki entri untuk restoran yang sesuai (`restoId`), jika belum maka buat entri baru dengan inisialisasi empty Map {}
      if (!menuItemsByRestoAndCategory.containsKey(restoMenuCategory.restoId)) {
        menuItemsByRestoAndCategory[restoMenuCategory.restoId] = {};
      }

      // Memeriksa apakah dalam Map yang terkait dengan `restoId` tertentu sudah ada entri untuk `menuCategoryId`, jika belum maka buat entri baru dengan inisialisasi empty array []
      if (!menuItemsByRestoAndCategory[restoMenuCategory.restoId]!
          .containsKey(restoMenuCategory.menuCategoryId)) {
        menuItemsByRestoAndCategory[restoMenuCategory.restoId]![
            restoMenuCategory.menuCategoryId] = [];
      }

      // Menambahkan menu ke dalam Map yang sesuai
      // Map<String, List<String>> restoMenuCategory = {
      //  '1': ['1', '2'],
      //  '2': ['3'],
      //  ....dst };
      menuItemsByRestoAndCategory[restoMenuCategory.restoId]![
              restoMenuCategory.menuCategoryId]!
          .addAll(menu);
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
              expandedHeight: screenHeight / 3,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  resto.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Stack(
                    children: [
                      SizedBox(
                        height: screenHeight / 2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5, left: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    border: Border.all(width: 1.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 5, bottom: 5),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 40, bottom: 10),
                                      child: Text(
                                        resto.description,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 40, bottom: 10),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Service Options : ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 40, bottom: 10),
                                      child: Text(
                                        resto.serviceOptions,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 40, bottom: 10),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Address : ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 40, bottom: 10),
                                      child: Text(
                                        [
                                          resto.street,
                                          resto.city,
                                          resto.postalCode
                                        ].join(' '),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Container(
                          width: screenWidth / 2,
                          height: screenHeight / 15,
                          color: Colors.white,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              resto.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight / 5,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/latin-food-bg.png'),
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: screenHeight / 20,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'M',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(fontSize: 48)
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight / 30,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'menus',
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverList.builder(
              itemCount: restoMenuCategories.length,
              itemBuilder: (context, catIndex) {
                final category = restoMenuCategories[catIndex];
                final menuItems = menuItemsByRestoAndCategory[resto.restoId]
                    ?[category.menuCategoryId];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            category.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                          ),
                        ),
                        Text(
                          category.subtitle ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        ),
                        Column(
                          children: menuItems!.map((menuItem) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        menuItem.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground),
                                      ),
                                      Text(
                                        'IDR ${menuItem.price.toString()}',
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
                                    child: SizedBox(
                                      width: screenWidth / 2,
                                      child: Text(
                                        menuItem.description ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
