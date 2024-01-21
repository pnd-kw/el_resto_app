import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:retaste_app/utils/layout/default_layout.dart';
import 'package:retaste_app/widget/restaurant_list_screen_widgets/textbox.dart';

class RestaurantListItem extends StatelessWidget {
  final String restaurantId;
  final String name;
  final String description;
  final String image;
  final String city;
  final double rating;

  const RestaurantListItem({
    super.key,
    required this.restaurantId,
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
    final defaultSize =
        DefaultSize(screenWidth: screenWidth, screenHeight: screenHeight);

    double cardHeight = defaultSize.cardHeight!;
    double bgTextBoxHeight = defaultSize.textBoxHeight!;
    double textBoxHeight = defaultSize.textBoxHeight!;
    double titleHeight = defaultSize.titleHeight!;
    double iconContainerHeight = defaultSize.iconContainerHeight!;
    double starIconContainerWidth = defaultSize.starIconContainerWidth!;
    double pinIconContainerWidth = defaultSize.pinIconContainerWidth!;

    if (ResponsiveBreakpoints.of(context).largerThan(MOBILE)) {
      cardHeight = screenHeight * 1.25;
      bgTextBoxHeight = screenHeight / 3;
      textBoxHeight = screenHeight / 3;
      titleHeight = screenHeight / 5;
      iconContainerHeight = screenHeight / 10;
      starIconContainerWidth = screenWidth / 8;
      pinIconContainerWidth = screenWidth / 3;
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
                            child: Hero(
                              tag: 'restaurantImage_$restaurantId',
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
                          child: TextBox(
                              height: bgTextBoxHeight, color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: TextBox(
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
