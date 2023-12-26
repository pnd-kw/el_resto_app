import 'package:flutter/material.dart';

class RestaurantMenuItem extends StatelessWidget {
  final String menuTitle;

  const RestaurantMenuItem({super.key, required this.menuTitle});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, right: 0, bottom: 10),
      child: Container(
        width: screenWidth / 3,
        height: 200,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 100,
                color: Colors.grey.shade300,
                child: Center(
                    child: Image.asset('assets/images/img-placeholder.png')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 0, right: 10, bottom: 10),
              child: Text(
                menuTitle,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
