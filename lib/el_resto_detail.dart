import 'package:el_resto_app/widget/el_resto_detail_info.dart';
import 'package:el_resto_app/widget/menu_item.dart';
import 'package:el_resto_app/widget/menu_category.dart';
import 'package:el_resto_app/model/menu.dart';
import 'package:el_resto_app/model/menu_category_list.dart';
import 'package:el_resto_app/model/menu_list.dart';
import 'package:el_resto_app/model/resto.dart';
import 'package:el_resto_app/model/resto_menu_category_list.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

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

    final screenHeight = MediaQuery.of(context).size.height;

    final mobileExpandedHeight = screenHeight / 3;
    final mobileMenuBgImage = screenHeight / 5;
    final mobileMlogoHeight = screenHeight / 20;
    final mobileMenusTitleHeight = screenHeight / 30;

    double expandedHeight = screenHeight / 1.5;
    double menuBgImage = screenHeight / 3;
    double mLogoHeight = screenHeight / 6;
    double menusTitleHeight = screenHeight / 10;

    if (ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE)) {
      expandedHeight = mobileExpandedHeight;
      menuBgImage = mobileMenuBgImage;
      mLogoHeight = mobileMlogoHeight;
      menusTitleHeight = mobileMenusTitleHeight;
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
                  child: Image.asset(
                    resto.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  ElRestoDetailInfo(
                    name: resto.name,
                    rating: resto.rating,
                    description: resto.description,
                    serviceOptions: resto.serviceOptions,
                    address:
                        [resto.street, resto.city, resto.postalCode].join(' '),
                    openHours: resto.openHours,
                  ),
                  SizedBox(
                    height: menuBgImage,
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
                            height: mLogoHeight,
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
                            height: menusTitleHeight,
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

                return MenuCategory(
                  title: category.title,
                  subtitle: category.subtitle ?? '',
                  column: Column(
                    children: menuItems!
                        .map((menuItems) => MenuItem(
                            name: menuItems.name,
                            price: menuItems.price,
                            description: menuItems.description))
                        .toList(),
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
