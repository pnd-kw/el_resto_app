import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class ElRestoDetailInfo extends StatelessWidget {
  final String name;
  final String description;
  final String serviceOptions;
  final String address;
  final String openHours;

  const ElRestoDetailInfo({
    super.key,
    required this.name,
    required this.description,
    required this.serviceOptions,
    required this.address,
    required this.openHours,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final mobileContainerHeight = screenHeight / 2;
    final mobileTitleContainerHeight = screenHeight / 15;

    double containerHeight = screenHeight / 1.2;
    double titleContainerHeight = screenHeight / 8;

    if (ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE)) {
      containerHeight = mobileContainerHeight;
      titleContainerHeight = mobileTitleContainerHeight;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            height: titleContainerHeight,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                name,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
          ),
        ),
        SizedBox(
          height: containerHeight,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoTitle(
                      context, 'About', const Icon(Icons.restaurant)),
                  buildInfoContent(context, 2, description),
                  buildInfoTitle(
                      context, 'Address', const Icon(Icons.pin_drop)),
                  buildInfoContent(context, 2, address),
                  buildInfoTitle(context, 'Service Options',
                      const Icon(Icons.table_restaurant)),
                  buildInfoContent(context, 1, serviceOptions),
                  buildInfoTitle(
                      context, 'Open Hours', const Icon(Icons.punch_clock)),
                  buildInfoContent(context, 0, openHours),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildInfoTitle(BuildContext context, String title, Widget icon) =>
    Flexible(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(child: icon),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget buildInfoContent(BuildContext context, int flex, String content) =>
    Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.only(left: 50, right: 20),
        child: AutoSizeText(
          content,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
          textAlign: TextAlign.justify,
          minFontSize: 9,
          overflow: TextOverflow.fade,
        ),
      ),
    );
