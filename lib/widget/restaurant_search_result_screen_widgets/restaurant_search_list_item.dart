import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:retaste_app/utils/layout/default_layout.dart';

class RestaurantSearchListItem extends StatelessWidget {
  final String restaurantId;
  final String name;
  final String description;
  final String image;
  final String city;
  final double rating;

  const RestaurantSearchListItem({
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
    final defaultSize = DefaultSize(
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        iconContainerHeight: screenHeight / 30,
        starIconContainerWidth: screenWidth / 6,
        pinIconContainerWidth: screenWidth / 4);

    double cardSizedBoxHeight = defaultSize.cardSizedBoxHeight!;
    double imgContainerHeight = defaultSize.imgContainerHeight!;
    double iconContainerHeight = defaultSize.iconContainerHeight!;
    double starIconContainerWidth = defaultSize.starIconContainerWidth!;
    double pinIconContainerWidth = defaultSize.pinIconContainerWidth!;

    if (ResponsiveBreakpoints.of(context).largerThan(MOBILE)) {
      cardSizedBoxHeight = screenHeight / 2;
      imgContainerHeight = screenHeight / 3;
      iconContainerHeight = screenHeight / 10;
      starIconContainerWidth = screenWidth / 8;
      pinIconContainerWidth = screenWidth / 4;
    }

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: cardSizedBoxHeight,
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Hero(
                  tag: 'restaurantImage_$restaurantId',
                  child: Container(
                    height: imgContainerHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://restaurant-api.dicoding.dev/images/small/$image'),
                          fit: BoxFit.cover),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(200),
                        topRight: Radius.circular(200),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(top: 5, right: 5, bottom: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 2,
                      child: SizedBox(
                        child: Text(
                          name,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Container(
                                width: starIconContainerWidth,
                                height: iconContainerHeight,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                        child: Align(
                                      alignment: Alignment.center,
                                      child: Icon(Icons.star_rate_rounded),
                                    )),
                                    Text(
                                      rating.toString(),
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
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  width: pinIconContainerWidth,
                                  height: iconContainerHeight,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                color: Theme.of(context)
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
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
    );
  }
}
