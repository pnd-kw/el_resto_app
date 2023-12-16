import 'package:el_resto_app/el_resto_list_item.dart';
import 'package:flutter/material.dart';
import 'package:el_resto_app/model/resto_list.dart';

class ElRestoList extends StatelessWidget {
  const ElRestoList({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'El Resto',
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: screenHeight,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListView.builder(
            itemCount: restoList.length,
            itemBuilder: (context, index) => ElRestoListItem(
                name: restoList[index].name,
                image: restoList[index].image,
                description: restoList[index].description,
                rating: restoList[index].rating,
                openHours: restoList[index].openHours),
          ),
          // child: Card(
          //   elevation: 0,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          //   child: SizedBox(
          //     height: screenHeight / 2,
          //     child: Stack(
          //       children: [
          //         SizedBox(
          //           child: Column(
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.only(
          //                     left: 20, top: 10, right: 20),
          //                 child: Stack(
          //                   children: [
          //                     Container(
          //                       height: screenHeight / 3.5,
          //                       decoration: BoxDecoration(
          //                         gradient: LinearGradient(
          //                           colors: [
          //                             Colors.grey.shade600,
          //                             Colors.grey.shade100,
          //                           ],
          //                           begin: Alignment.topCenter,
          //                           end: Alignment.bottomCenter,
          //                         ),
          //                         borderRadius: const BorderRadius.only(
          //                           topLeft: Radius.circular(200),
          //                           topRight: Radius.circular(200),
          //                         ),
          //                       ),
          //                     ),
          //                     Padding(
          //                       padding: const EdgeInsets.only(top: 5),
          //                       child: Container(
          //                         height: screenHeight / 3.5,
          //                         decoration: const BoxDecoration(
          //                           image: DecorationImage(
          //                             image: AssetImage(
          //                                 'assets/images/sudestada-restaurant.jpg'),
          //                             fit: BoxFit.cover,
          //                           ),
          //                           borderRadius: BorderRadius.only(
          //                             topLeft: Radius.circular(200),
          //                             topRight: Radius.circular(200),
          //                           ),
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //               Stack(
          //                 children: [
          //                   Padding(
          //                     padding: const EdgeInsets.only(
          //                         left: 25, top: 25, right: 15, bottom: 15),
          //                     child: Container(
          //                       height: screenHeight / 6,
          //                       decoration: BoxDecoration(
          //                         color: Colors.white,
          //                         borderRadius: const BorderRadius.only(
          //                           bottomLeft: Radius.circular(20),
          //                           bottomRight: Radius.circular(20),
          //                         ),
          //                         border: Border.all(width: 1.0),
          //                       ),
          //                     ),
          //                   ),
          //                   Padding(
          //                     padding: const EdgeInsets.only(
          //                         left: 20, top: 20, right: 20, bottom: 20),
          //                     child: Container(
          //                       height: screenHeight / 6,
          //                       decoration: BoxDecoration(
          //                         color: Colors.grey.shade300,
          //                         borderRadius: const BorderRadius.only(
          //                           bottomLeft: Radius.circular(20),
          //                           bottomRight: Radius.circular(20),
          //                         ),
          //                         border: Border.all(width: 1.0),
          //                       ),
          //                       child: Column(
          //                         children: [
          //                           Padding(
          //                             padding: const EdgeInsets.symmetric(
          //                                 vertical: 5, horizontal: 10),
          //                             child: Row(
          //                               mainAxisAlignment:
          //                                   MainAxisAlignment.start,
          //                               children: [
          //                                 SizedBox(
          //                                     height: screenHeight / 40,
          //                                     child: const Icon(
          //                                         Icons.star_border)),
          //                                 Padding(
          //                                   padding: const EdgeInsets.only(
          //                                       left: 5, top: 5),
          //                                   child: Text(
          //                                     '4.7',
          //                                     style: Theme.of(context)
          //                                         .textTheme
          //                                         .bodyMedium!
          //                                         .copyWith(
          //                                             color: Theme.of(context)
          //                                                 .colorScheme
          //                                                 .onBackground),
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                           Padding(
          //                             padding: const EdgeInsets.symmetric(
          //                                 vertical: 10, horizontal: 10),
          //                             child: Text(
          //                               'Sudestada is regarded as an auspicious name in Argentinian culture. In Spanish, it means “powerful wind,” particularly that cool strong breeze before a mighty storm.',
          //                               style: Theme.of(context)
          //                                   .textTheme
          //                                   .bodySmall!
          //                                   .copyWith(
          //                                       color: Theme.of(context)
          //                                           .colorScheme
          //                                           .onBackground),
          //                               textAlign: TextAlign.justify,
          //                             ),
          //                           ),
          //                           Padding(
          //                             padding: const EdgeInsets.symmetric(
          //                                 horizontal: 10),
          //                             child: Row(
          //                               mainAxisAlignment:
          //                                   MainAxisAlignment.end,
          //                               children: [
          //                                 Padding(
          //                                   padding:
          //                                       const EdgeInsets.only(top: 5),
          //                                   child: Text(
          //                                     'Open Hours: ',
          //                                     style: Theme.of(context)
          //                                         .textTheme
          //                                         .labelSmall!
          //                                         .copyWith(
          //                                             color: Theme.of(context)
          //                                                 .colorScheme
          //                                                 .onBackground),
          //                                   ),
          //                                 ),
          //                                 Padding(
          //                                   padding: const EdgeInsets.only(
          //                                       left: 5, top: 5),
          //                                   child: Text(
          //                                     '11 AM - 10 PM',
          //                                     style: Theme.of(context)
          //                                         .textTheme
          //                                         .labelSmall!
          //                                         .copyWith(
          //                                             color: Theme.of(context)
          //                                                 .colorScheme
          //                                                 .onBackground),
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                   Padding(
          //                     padding: const EdgeInsets.all(20),
          //                     child: ElevatedButton(
          //                         onPressed: () {
          //                           Navigator.of(context)
          //                               .pushNamed('/el-resto-detail');
          //                         },
          //                         child: const Text('Next')),
          //                   )
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ),
          //         Container(
          //           width: screenWidth / 2,
          //           height: screenHeight / 15,
          //           decoration: const BoxDecoration(
          //             color: Colors.white,
          //             borderRadius: BorderRadius.only(
          //               topLeft: Radius.circular(20),
          //               bottomRight: Radius.circular(40),
          //             ),
          //           ),
          //           child: Padding(
          //             padding: const EdgeInsets.only(right: 20),
          //             child: Align(
          //               alignment: Alignment.bottomRight,
          //               child: Text(
          //                 'SUDESTADA',
          //                 style: Theme.of(context)
          //                     .textTheme
          //                     .headlineLarge!
          //                     .copyWith(
          //                         color: Theme.of(context)
          //                             .colorScheme
          //                             .onBackground),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ),
        // child: Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        //   child: Column(
        //     children: [
        //       Container(
        //         width: double.infinity,
        //         height: screenHeight / 4,
        //         child: Stack(children: [
        //           Container(
        //             decoration: BoxDecoration(
        //               gradient: LinearGradient(
        //                   colors: [
        //                     Colors.grey.shade600,
        //                     Colors.grey.shade200,
        //                     // Color.fromARGB(1, 192, 196, 193),
        //                     // Color.fromARGB(1, 197, 201, 198),
        //                     // Color.fromARGB(1, 217, 222, 218),
        //                     // Color.fromARGB(1, 230, 235, 231),
        //                   ],
        //                   begin: Alignment.topCenter,
        //                   end: Alignment.bottomCenter),
        //               borderRadius: BorderRadius.only(
        //                   topLeft: Radius.circular(200),
        //                   topRight: Radius.circular(200)),
        //             ),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.all(10),
        //             child: Container(
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.only(
        //                     topLeft: Radius.circular(200),
        //                     topRight: Radius.circular(200)),
        //                 image: DecorationImage(
        //                   image: AssetImage(
        //                     'assets/images/sudestada-restaurant.jpg',
        //                   ),
        //                   fit: BoxFit.cover,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ]),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
