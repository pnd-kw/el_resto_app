import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class RestaurantListItem extends StatelessWidget {
  final String name;
  final String description;
  final String image;
  final String city;
  final double rating;

  const RestaurantListItem({
    super.key,
    required this.name,
    required this.description,
    required this.image,
    required this.city,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final mobileCardHeight = screenHeight / 2;
    final mobileTextBoxHeight = screenHeight / 6;
    final mobileTitleHeight = screenHeight / 12;
    final mobileIconContainerHeight = screenHeight / 30;
    final mobileStarIconContainerWidth = screenWidth / 6;
    final mobilePinIconContainerWidth = screenWidth / 2;

    double cardHeight = screenHeight * 1.25;
    double bgTextBoxHeight = screenHeight / 3;
    double textBoxHeight = screenHeight / 3;
    double titleHeight = screenHeight / 5;
    double iconContainerHeight = screenHeight / 10;
    double starIconContainerWidth = screenWidth / 8;
    double pinIconContainerWidth = screenWidth / 3;

    if (ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE)) {
      cardHeight = mobileCardHeight;
      bgTextBoxHeight = mobileTextBoxHeight;
      textBoxHeight = mobileTextBoxHeight;
      titleHeight = mobileTitleHeight;
      iconContainerHeight = mobileIconContainerHeight;
      starIconContainerWidth = mobileStarIconContainerWidth;
      pinIconContainerWidth = mobilePinIconContainerWidth;
    }

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: cardHeight,
        child: Stack(
          children: [
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 10, right: 20),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.grey.shade600,
                                  Colors.grey.shade100,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(200),
                                topRight: Radius.circular(200),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://restaurant-api.dicoding.dev/images/small/$image'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(200),
                                  topRight: Radius.circular(200),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25, top: 25, right: 15, bottom: 15),
                          child: buildTextBox(
                            height: bgTextBoxHeight,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: buildTextBox(
                            height: textBoxHeight,
                            color: Colors.grey.shade300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Container(
                                            width: starIconContainerWidth,
                                            height: iconContainerHeight,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                    child: Align(
                                                  alignment: Alignment.center,
                                                  child: Icon(
                                                      Icons.star_rate_rounded),
                                                )),
                                                Text(
                                                  rating.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .colorScheme
                                                              .onBackground),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Container(
                                              width: pinIconContainerWidth,
                                              height: iconContainerHeight,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const SizedBox(
                                                      child: Align(
                                                    alignment: Alignment.center,
                                                    child: Icon(Icons.pin_drop),
                                                  )),
                                                  Text(
                                                    city,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onBackground),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: AutoSizeText(
                                      description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground),
                                      textAlign: TextAlign.justify,
                                      minFontSize: 9,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
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
                ],
              ),
            ),
            SizedBox(
              height: titleHeight,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: screenWidth / 2,
                  height: titleHeight,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        name,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                        textAlign: TextAlign.center,
                      ),
                    ),
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

Widget buildTextBox(
        {required double height, required Color color, Widget? child}) =>
    Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        border: Border.all(width: 1.0),
      ),
      child: child,
    );
