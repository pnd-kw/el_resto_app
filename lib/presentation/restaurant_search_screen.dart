import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:retaste_app/bloc/cubit/cubit/restaurant_search_keywords_cubit.dart';
import 'package:retaste_app/bloc/restaurant_bloc.dart';
import 'package:retaste_app/presentation/restaurant_search_result_screen.dart';
import 'package:retaste_app/utils/layout/default_layout.dart';
import 'package:retaste_app/widget/restaurant_search_screen_widgets/chip_button.dart';

class RestaurantSearchScreen extends StatefulWidget {
  const RestaurantSearchScreen({super.key});

  @override
  State<RestaurantSearchScreen> createState() => _RestaurantSearchScreenState();
}

class _RestaurantSearchScreenState extends State<RestaurantSearchScreen> {
  late RestaurantSearchKeywordsCubit restaurantSearchKeywordsCubit;

  @override
  void initState() {
    restaurantSearchKeywordsCubit =
        BlocProvider.of<RestaurantSearchKeywordsCubit>(context);
    restaurantSearchKeywordsCubit.loadSearchKeywords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final defaultSize =
        DefaultSize(screenWidth: screenWidth, screenHeight: screenHeight);

    int textFieldFlex = defaultSize.textFieldFlex!;
    int searchHistoryTitleFlex = defaultSize.searchHistoryTitleFlex!;
    int chipButtonFlex = defaultSize.chipButtonFlex!;
    double bgImgHeight = defaultSize.bgImgHeight!;
    double textFieldHeight = defaultSize.textFieldHeight!;
    double chipButtonHeight = defaultSize.chipButtonHeight!;

    if (ResponsiveBreakpoints.of(context).largerThan(MOBILE)) {
      textFieldFlex = 10;
      searchHistoryTitleFlex = 4;
      chipButtonFlex = 6;
      bgImgHeight = screenHeight / 4;
      textFieldHeight = screenHeight / 7;
      chipButtonHeight = screenHeight / 15;
    }

    final textSearchController = TextEditingController();

    final restaurantBloc = BlocProvider.of<RestaurantBloc>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Search',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: screenHeight,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
          ),
          Center(
            child: SizedBox(
              height: bgImgHeight,
              child: Image.asset('assets/images/search-placeholder.png'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: textFieldFlex,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: textFieldHeight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: textSearchController,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.search),
                              hintText:
                                  'Write down a restaurant name or menu to find restaurant...',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 0.5),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 1),
                                borderRadius: BorderRadius.circular(30),
                              )),
                          onSubmitted: (value) {
                            if (textSearchController.text.isNotEmpty) {
                              restaurantSearchKeywordsCubit
                                  .saveSearchKeyword(textSearchController.text);
                              restaurantBloc.add(FetchRestaurantByQuery(
                                  textSearchController.text));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchResultScreen(
                                    initialSearchText:
                                        textSearchController.text,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: searchHistoryTitleFlex,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: SizedBox(
                      child: Text(
                        'Your history',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: chipButtonFlex,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BlocConsumer<RestaurantSearchKeywordsCubit,
                        RestaurantSearchKeywordsState>(
                      listenWhen: (previous, current) => current
                          is RestaurantSearchKeywordNavigatorActionState,
                      buildWhen: (previous, current) =>
                          current is RestaurantSearchKeywordsLoaded,
                      listener: (context, state) {
                        if (state
                            is RestaurantSearchKeywordNavigatorActionState) {
                          restaurantSearchKeywordsCubit
                              .saveSearchKeyword(state.keyword);
                          restaurantBloc
                              .add(FetchRestaurantByQuery(state.keyword));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchResultScreen(
                                      initialSearchText: state.keyword)));
                        }
                      },
                      builder: (context, state) {
                        if (state is RestaurantSearchKeywordsLoaded) {
                          List<Widget> chipButtons = [];

                          List<String> displayedKeywords =
                              state.searchKeywords.take(6).toList();

                          for (String keyword in displayedKeywords) {
                            chipButtons.add(ChipButton(
                                width: screenWidth / 4,
                                height: chipButtonHeight,
                                onTap: () {
                                  restaurantSearchKeywordsCubit
                                      .navigatorAction(keyword);
                                },
                                keyword: keyword));
                          }

                          return chipButtons.isNotEmpty
                              ? Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Wrap(
                                      alignment: WrapAlignment.start,
                                      spacing: 2.0,
                                      runSpacing: 2.0,
                                      children: chipButtons,
                                    ),
                                  ],
                                )
                              : const Center(
                                  child: SizedBox(),
                                );
                        } else {
                          return Center(
                            child: SizedBox(
                              height: screenHeight / 20,
                              child: Text(
                                'Unknown state',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
