import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class ElRestoDetailInfo extends StatelessWidget {
  final String name;
  final double rating;
  final String description;
  final String serviceOptions;
  final String address;
  final String openHours;

  const ElRestoDetailInfo({
    super.key,
    required this.name,
    required this.rating,
    required this.description,
    required this.serviceOptions,
    required this.address,
    required this.openHours,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final mobileContainerHeight = screenHeight / 2;
    final mobileTitleContainerHeight = screenHeight / 15;
    final mobileStarImgWidth = screenWidth / 9;
    final mobileStarImgHeight = screenHeight / 20;
    final mobileRatingWidth = screenWidth / 9;

    double containerHeight = screenHeight / 1.2;
    double titleContainerHeight = screenHeight / 8;
    double starImgWidth = screenWidth / 20;
    double starImgHeight = screenHeight / 10;
    double ratingWidth = screenWidth / 20;

    if (ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE)) {
      containerHeight = mobileContainerHeight;
      titleContainerHeight = mobileTitleContainerHeight;
      starImgWidth = mobileStarImgWidth;
      starImgHeight = mobileStarImgHeight;
      ratingWidth = mobileRatingWidth;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            height: titleContainerHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    name,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
                Flexible(
                  child: Stack(
                    children: [
                      SizedBox(
                        width: starImgWidth,
                        height: starImgHeight,
                        child: Image.asset(
                          'assets/images/star.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(
                        width: ratingWidth,
                        height: starImgHeight,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            rating.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ),
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
        padding: const EdgeInsets.only(left: 55, right: 20),
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
