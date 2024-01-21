import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:retaste_app/utils/layout/default_layout.dart';
import 'package:retaste_app/widget/restaurant_detail_screen_widgets/custom_text_button.dart';
import 'package:retaste_app/widget/restaurant_detail_screen_widgets/info_content.dart';
import 'package:retaste_app/widget/restaurant_detail_screen_widgets/info_title.dart';

class RestaurantDetailInfo extends StatefulWidget {
  final String name;
  final List<String> categoryName;
  final double rating;
  final String description;
  final String city;
  final String address;

  const RestaurantDetailInfo({
    super.key,
    required this.name,
    required this.categoryName,
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
    final defaultSize =
        DefaultSize(screenWidth: screenWidth, screenHeight: screenHeight);

    double titleContainerHeight = defaultSize.titleContainerHeight!;
    double starImgWidth = defaultSize.starImgWidth!;
    double starImgHeight = defaultSize.starImgHeight!;
    double ratingWidth = defaultSize.ratingWidth!;
    double categorySizedBoxHeight = defaultSize.categorySizedBoxHeight!;
    double containerHeight = defaultSize.containerHeight!;
    double expandedContainerHeight = defaultSize.expandedContainerHeight!;
    int containerFlex = defaultSize.containerFlex!;
    int expandedContainerFlex = defaultSize.expandedContainerFlex!;

    if (ResponsiveBreakpoints.of(context).largerThan(MOBILE)) {
      titleContainerHeight = screenHeight / 8;
      starImgWidth = screenWidth / 20;
      starImgHeight = screenHeight / 10;
      ratingWidth = screenWidth / 20;
      categorySizedBoxHeight = screenHeight / 20;
      containerHeight = screenHeight / 1.6;
      expandedContainerHeight = screenHeight;
      containerFlex = 1;
      expandedContainerFlex = 3;
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
                    widget.name,
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
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SizedBox(
              height: categorySizedBoxHeight,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.categoryName.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Container(
                      width: screenWidth / 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.categoryName[index],
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
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
                  const InfoTitle(title: 'About', icon: Icon(Icons.restaurant)),
                  InfoContent(
                      flex: isExpanded ? expandedContainerFlex : containerFlex,
                      text: Text(
                        widget.description,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                        textAlign: TextAlign.justify,
                        maxLines: isExpanded ? null : 2,
                        overflow: isExpanded ? null : TextOverflow.ellipsis,
                      )),
                  CustomTextButton(
                    flex: 1,
                    textButton: TextButton(
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
                  const InfoTitle(
                      title: 'City', icon: Icon(Icons.location_city_rounded)),
                  InfoContent(
                      flex: 1,
                      text: Text(
                        widget.city,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      )),
                  const InfoTitle(
                      title: 'Address', icon: Icon(Icons.pin_drop_rounded)),
                  InfoContent(
                      flex: 1,
                      text: Text(
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
