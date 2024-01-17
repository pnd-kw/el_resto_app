import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:retaste_app/utils/layout/default_layout.dart';

class CustomerReviewItem extends StatelessWidget {
  final String name;
  final String date;
  final String review;

  const CustomerReviewItem({
    super.key,
    required this.name,
    required this.date,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final defaultSize =
        DefaultSize(screenWidth: screenWidth, screenHeight: screenHeight);

    double contentSizedBoxHeight = defaultSize.contentSizedBoxHeight!;
    double imgSizedBoxWidth = defaultSize.imgSizedBoxWidth!;
    double imgSizedBoxHeight = defaultSize.imgSizedboxHeight!;
    double reviewInfoSizedBoxHeight = defaultSize.reviewInfoSizedBoxHeight!;

    if (ResponsiveBreakpoints.of(context).largerThan(MOBILE)) {
      contentSizedBoxHeight = screenHeight / 3;
      imgSizedBoxWidth = screenWidth / 6;
      imgSizedBoxHeight = screenHeight / 3;
      reviewInfoSizedBoxHeight = screenHeight / 3;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: SizedBox(
            height: contentSizedBoxHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: imgSizedBoxWidth,
                      height: imgSizedBoxHeight,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/profile-img-placeholder.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(
                      height: reviewInfoSizedBoxHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground),
                                  textAlign: TextAlign.start,
                                ),
                              )),
                          Flexible(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  date,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground),
                                  textAlign: TextAlign.start,
                                ),
                              )),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  review,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground),
                                  textAlign: TextAlign.justify,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
