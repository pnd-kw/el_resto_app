import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

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

    // final mobileImgSizedBoxWidth = screenWidth / 4;
    final mobileContentSizedBoxHeight = screenHeight / 6;
    final mobileImgSizedBoxWidth = screenWidth / 4;
    final mobileImgSizedBoxHeight = screenHeight / 10;
    final mobileReviewInfoSizedBoxHeight = screenHeight / 8;

    double contentSizedBoxHeight = screenHeight / 3;
    double imgSizedBoxWidth = screenWidth / 6;
    double imgSizedBoxHeight = screenHeight / 3;
    double reviewInfoSizedBoxHeight = screenHeight / 3;

    if (ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE)) {
      contentSizedBoxHeight = mobileContentSizedBoxHeight;
      imgSizedBoxWidth = mobileImgSizedBoxWidth;
      imgSizedBoxHeight = mobileImgSizedBoxHeight;
      reviewInfoSizedBoxHeight = mobileReviewInfoSizedBoxHeight;
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
                                  // 'John Doe',
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
                                  // '29 Desember 2023',
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
                                  // 'Makanan nya enak, banyak pilihan menu, harga cukup bersahabat!',
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
