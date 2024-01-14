import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:retaste_app/bloc/cubit/cubit/restaurant_search_keywords_cubit.dart';
import 'package:retaste_app/bloc/restaurant_bloc.dart';
// import 'package:retaste_app/widget/restaurant_list_item.dart';
import 'package:retaste_app/widget/restaurant_search_list_item.dart';

class SearchResultScreen extends StatefulWidget {
  // final GlobalKey<FormFieldState<String>> textFieldKey;

  final String initialSearchText;

  const SearchResultScreen({
    super.key,
    // required this.textFieldKey,
    // required this.textSearchController,
    required this.initialSearchText,
  });

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late TextEditingController textSearchController;
  late RestaurantBloc _restaurantBloc;

  @override
  void initState() {
    textSearchController =
        TextEditingController(text: widget.initialSearchText);
    _restaurantBloc = BlocProvider.of<RestaurantBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final restaurantBloc = BlocProvider.of<RestaurantBloc>(context);

    const mobileTextFieldFlex = 1;
    final mobileBgImageHeight = screenHeight / 5;
    final mobileTextFieldHeight = screenHeight / 15;

    int textFieldFlex = 4;
    double bgImageHeight = screenHeight / 4;
    double textFieldHeight = screenHeight / 7;

    if (ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE)) {
      textFieldFlex = mobileTextFieldFlex;
      bgImageHeight = mobileBgImageHeight;
      textFieldHeight = mobileTextFieldHeight;
    }

    final restaurantSearchKeywordsCubit =
        BlocProvider.of<RestaurantSearchKeywordsCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Search Results',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: screenHeight,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
        child: SizedBox(
          width: double.infinity,
          height: screenHeight,
          child: Column(
            children: [
              Expanded(
                flex: textFieldFlex,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    height: textFieldHeight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: textSearchController,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
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
                            // _restaurantBloc.add(AddSearchKeywordEvent(
                            //     textSearchController.text));
                            restaurantSearchKeywordsCubit
                                .saveSearchKeyword(textSearchController.text);
                            _restaurantBloc.add(FetchRestaurantByQuery(
                                textSearchController.text));
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: BlocConsumer<RestaurantBloc, RestaurantState>(
                      listenWhen: (previous, current) =>
                          current is RestaurantSearchActionState,
                      buildWhen: (previous, current) =>
                          current is RestaurantByQueryEmpty ||
                          current is RestaurantByQueryLoaded,
                      listener: (context, state) {
                        if (state is RestaurantSearchNavigatorActionState) {
                          String restaurantId = state.id;
                          Navigator.of(context).pushNamed(
                              '/restaurant-detail-screen',
                              arguments: restaurantId);
                        }
                      },
                      builder: (context, state) {
                        if (state is RestaurantByQueryLoading) {
                          return Center(
                            child: SizedBox(
                              height: screenHeight / 20,
                              child: const CircularProgressIndicator(),
                            ),
                          );
                        } else if (state is RestaurantByQueryEmpty) {
                          return SizedBox(
                            height: screenHeight,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: bgImageHeight,
                                    child: Image.asset(
                                      'assets/images/search-placeholder.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenHeight / 12,
                                    child: Text(
                                      "We're sorry, but there were no matches for your search.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        } else if (state is RestaurantByQueryLoaded) {
                          return ListView.builder(
                              itemCount: state.restaurants.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    String restaurantId =
                                        state.restaurants[index].id;
                                    _restaurantBloc.add(
                                        RestaurantSearchNavigatorActionEvent(
                                            restaurantId));
                                  },
                                  child: RestaurantSearchListItem(
                                      name: state.restaurants[index].name,
                                      description:
                                          state.restaurants[index].description,
                                      image: state.restaurants[index].pictureId,
                                      city: state.restaurants[index].city,
                                      rating: state.restaurants[index].rating),
                                );
                              });
                        } else if (state is RestaurantByQueryError) {
                          return Center(
                            child: Text(state.errorMessage),
                          );
                        } else {
                          return const Center(
                            child: Center(
                              child: Text('Unknown state'),
                            ),
                          );
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
