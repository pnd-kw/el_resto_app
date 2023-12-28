import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class RestaurantDetailInfo extends StatefulWidget {
  final String name;
  // final List<String> categoryName;
  final double rating;
  final String description;
  final String city;
  final String address;

  const RestaurantDetailInfo({
    super.key,
    required this.name,
    // required this.categoryName,
    required this.rating,
    required this.description,
    required this.city,
    required this.address,
  });

  @override
  State<RestaurantDetailInfo> createState() => _RestaurantDetailInfoState();
}

class _RestaurantDetailInfoState extends State<RestaurantDetailInfo> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final mobileTitleContainerHeight = screenHeight / 15;
    final mobileStarImgWidth = screenWidth / 9;
    final mobileStarImgHeight = screenHeight / 20;
    final mobileRatingWidth = screenWidth / 9;
    final mobileContainerHeight = screenHeight / 3;
    final mobileExpandedContainerHeight = screenHeight / 1.8;
    const mobileContainerFlex = 1;
    const mobileExpandedContainerFlex = 9;

    double titleContainerHeight = screenHeight / 8;
    double starImgWidth = screenWidth / 20;
    double starImgHeight = screenHeight / 10;
    double ratingWidth = screenWidth / 20;
    double containerHeight = screenHeight / 1.8;
    double expandedContainerHeight = screenHeight / 1.2;
    int containerFlex = 2;
    int expandedContainerFlex = 2;

    if (ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE)) {
      containerHeight = mobileContainerHeight;
      expandedContainerHeight = mobileExpandedContainerHeight;
      titleContainerHeight = mobileTitleContainerHeight;
      starImgWidth = mobileStarImgWidth;
      starImgHeight = mobileStarImgHeight;
      ratingWidth = mobileRatingWidth;
      containerFlex = mobileContainerFlex;
      expandedContainerFlex = mobileExpandedContainerFlex;
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
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.name,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        ),
                      ),
                      // Flexible(
                      //   child: ListView.builder(
                      //     itemCount: widget.categoryName.length,
                      //     itemBuilder: (context, index) {
                      //       return Text(
                      //         widget.categoryName[index],
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .labelSmall!
                      //             .copyWith(
                      //                 color: Theme.of(context)
                      //                     .colorScheme
                      //                     .onBackground),
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
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
                            widget.rating.toString(),
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
        ),
        SizedBox(
          height: isExpanded ? expandedContainerHeight : containerHeight,
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
                  buildInfoContent(
                      context,
                      isExpanded ? expandedContainerFlex : containerFlex,
                      Text(
                        widget.description,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                        textAlign: TextAlign.justify,
                        maxLines: isExpanded ? null : 2,
                        overflow: isExpanded ? null : TextOverflow.ellipsis,
                      )),
                  buildTextButton(
                    context,
                    1,
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: Text(
                          isExpanded ? 'Show less' : 'Show more',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                        )),
                  ),
                  buildInfoTitle(
                      context, 'City', const Icon(Icons.location_city_rounded)),
                  buildInfoContent(
                      context,
                      1,
                      Text(
                        widget.city,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      )),
                  buildInfoTitle(
                      context, 'Address', const Icon(Icons.pin_drop_rounded)),
                  buildInfoContent(
                      context,
                      1,
                      Text(
                        widget.address,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      )),
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

Widget buildInfoContent(BuildContext context, int flex, Widget text) =>
    Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.only(left: 55, right: 20),
        child: text,
      ),
    );

Widget buildTextButton(BuildContext context, int flex, TextButton textButton) =>
    Flexible(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.only(left: 40, right: 20),
        child: textButton,
      ),
    );
