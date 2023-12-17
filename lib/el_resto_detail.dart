import 'package:el_resto_app/model/menu_category.dart';
import 'package:el_resto_app/model/menu_category_list.dart';
import 'package:el_resto_app/model/resto.dart';
import 'package:flutter/material.dart';

class ElRestoDetail extends StatelessWidget {
  const ElRestoDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final resto = ModalRoute.of(context)!.settings.arguments as Resto;

    final List<MenuCategory> filteredCategories = menuCategoryList
        .where((category) => category.restoId == resto.id)
        .toList();

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
                  // margin: const EdgeInsets.all(10),
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
                  // 'assets/images/sudestada-restaurant.jpg',
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
                                        // 'Sudestada is regarded as an auspicious name in Argentinian culture. In Spanish, it means “powerful wind,” particularly that cool strong breeze before a mighty storm.',
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
                                        // 'Has outdoor seating · Serves great cocktails · Has live music',
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
                                        '${resto.street}${resto.city}${resto.postalCode}',
                                        // 'Jl. Irian No.18, RT.9/RW.5, Gondangdia, Kec. Menteng, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10350',
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
                              // 'SUDESTADA',
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
                      // child: Center(
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
                      // ),
                    ),
                  ),
                ],
              ),
            ),
            SliverList.builder(
              itemCount: filteredCategories.length,
              itemBuilder: (context, catIndex) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text(
                        filteredCategories[catIndex].title,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      Text(
                        filteredCategories[catIndex].subtitle ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                      ),
                      Column(
                        children: List.generate(
                            filteredCategories[catIndex].menuItems.length,
                            (menuIndex) {
                          final menuItem =
                              filteredCategories[catIndex].menuItems[menuIndex];
                          return ListTile(
                            title: Text(
                              menuItem.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                            ),
                            subtitle: Text(
                              menuItem.description ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                            ),
                            trailing: Text(
                              menuItem.price.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                            ),
                          );
                        }),
                      )
                    ],
                    // child: ListView.builder(
                    //   itemCount: menuCategoryList.length,
                    //   itemBuilder: (context, index) => SizedBox(
                    //     child: Column(
                    //       children: [
                    //         Text(menuCategoryList[index].title),
                    //         Text(menuCategoryList[index].subtitle ?? ''),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
