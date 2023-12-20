import 'package:flutter/material.dart';

class MenuCategory extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget column;

  const MenuCategory({
    super.key,
    required this.title,
    required this.subtitle,
    required this.column,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
            Text(
              subtitle,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            column,
          ],
        ),
      ),
    );
  }
}
