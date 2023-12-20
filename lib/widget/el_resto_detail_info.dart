import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class ElRestoDetailInfo extends StatelessWidget {
  final String name;
  final String description;
  final String serviceOptions;
  final String address;

  const ElRestoDetailInfo(
      {super.key,
      required this.name,
      required this.description,
      required this.serviceOptions,
      required this.address});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final mobileContainerHeight = screenHeight / 2;
    final mobileTitleContainerHeight = screenHeight / 15;

    double containerHeight = screenHeight / 1.2;
    double titleContainerHeight = screenHeight / 8;

    if (ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE)) {
      containerHeight = mobileContainerHeight;
      titleContainerHeight = mobileTitleContainerHeight;
    }

    return Stack(
      children: [
        SizedBox(
          height: containerHeight,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      border: Border.all(width: 1.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5, bottom: 5),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 40, bottom: 10),
                        child: Text(
                          description,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 40, bottom: 10),
                        // child: Align(
                        //   alignment: Alignment.centerLeft,
                        child: Text(
                          'Service Options : ',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background),
                        ),
                        // ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 40, bottom: 10),
                        child: Text(
                          serviceOptions,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 40, bottom: 10),
                        // child: Align(
                        //   alignment: Alignment.centerLeft,
                        child: Text(
                          'Address : ',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background),
                        ),
                        // ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 40, bottom: 10),
                        child: Text(
                          address,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            width: screenWidth / 2,
            height: titleContainerHeight,
            color: Colors.white,
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
      ],
    );
  }
}
