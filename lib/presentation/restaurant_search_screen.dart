import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retaste_app/bloc/restaurant_bloc.dart';
import 'package:retaste_app/presentation/restaurant_search_result_screen.dart';
// import 'package:retaste_app/widget/restaurant_list_item.dart';

class RestaurantSearchScreen extends StatelessWidget {
  const RestaurantSearchScreen({super.key});

  // final GlobalKey<FormFieldState<String>> _searchFieldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
      body: SizedBox(
        width: double.infinity,
        height: screenHeight,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: screenHeight / 20,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      // key: _searchFieldKey,
                      controller: textSearchController,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                      decoration: InputDecoration(
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
                          restaurantBloc.add(FetchRestaurantByQuery(
                              textSearchController.text));
                          // Navigator.pushNamed(context, '/searchResult',
                          //     arguments: SearchResultArguments(
                          //         textFieldKey: _searchFieldKey,
                          //         textSearchController: textSearchController));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchResultScreen(
                                        initialSearchText:
                                            textSearchController.text,
                                        // textSearchController: textSearchController,
                                      )));
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Center(
                child: SizedBox(
                  height: screenHeight / 5,
                  child: Image.asset('assets/images/search-placeholder.png'),
                ),
              ),
              // child: Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: BlocConsumer<RestaurantBloc, RestaurantState>(
              //       listener: (context, state) {},
              //       builder: (context, state) {
              //         print('Builder: $state');
              //         if (state is RestaurantByQueryInitial) {
              //           return Center(
              //             child: SizedBox(
              //               height: screenHeight / 5,
              //               child: Image.asset(
              //                 'assets/images/search-placeholder.png',
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           );
              //         } else if (state is RestaurantByQueryLoading) {
              //           return Center(
              //             child: SizedBox(
              //               height: screenHeight / 20,
              //               child: const CircularProgressIndicator(),
              //             ),
              //           );
              //         } else if (state is RestaurantByQueryEmpty) {
              //           return SizedBox(
              //             height: screenHeight,
              //             child: Center(
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   SizedBox(
              //                     height: screenHeight / 5,
              //                     child: Image.asset(
              //                       'assets/images/search-placeholder.png',
              //                       fit: BoxFit.cover,
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     height: screenHeight / 12,
              //                     child: Text(
              //                       "We're sorry, but there were no matches for your search.",
              //                       style: Theme.of(context)
              //                           .textTheme
              //                           .labelSmall!
              //                           .copyWith(
              //                               color: Theme.of(context)
              //                                   .colorScheme
              //                                   .onBackground),
              //                       textAlign: TextAlign.center,
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             ),
              //           );
              //         } else if (state is RestaurantByQueryLoaded) {
              //           return ListView.builder(
              //               itemCount: state.restaurants.length,
              //               itemBuilder: (context, index) {
              //                 return RestaurantListItem(
              //                     name: state.restaurants[index].name,
              //                     description:
              //                         state.restaurants[index].description,
              //                     image: state.restaurants[index].pictureId,
              //                     city: state.restaurants[index].city,
              //                     rating: state.restaurants[index].rating);
              //               });
              //         } else if (state is RestaurantByQueryError) {
              //           return Center(
              //             child: Text(state.errorMessage),
              //           );
              //         } else {
              //           return const Center(
              //             child: Center(
              //               child: Text('Unknown state'),
              //             ),
              //           );
              //         }
              //       }),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
