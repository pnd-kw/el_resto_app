// import 'package:flutter/material.dart';

// class MenuList extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final 
//   const MenuList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//       child: Container(
//         color: Colors.white,
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 10),
//               child: Text(
//                 filteredCategories[catIndex].title,
//                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                     color: Theme.of(context).colorScheme.onBackground),
//               ),
//             ),
//             Text(
//               filteredCategories[catIndex].subtitle ?? '',
//               style: Theme.of(context)
//                   .textTheme
//                   .titleMedium!
//                   .copyWith(color: Theme.of(context).colorScheme.onBackground),
//             ),
//             Column(
//               children: List.generate(
//                   filteredCategories[catIndex].menuItems.length, (menuIndex) {
//                 final menuItem =
//                     filteredCategories[catIndex].menuItems[menuIndex];
//                 return Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             menuItem.name,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyMedium!
//                                 .copyWith(
//                                     color: Theme.of(context)
//                                         .colorScheme
//                                         .onBackground),
//                           ),
//                           Text(
//                             'IDR ${menuItem.price.toString()}',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyMedium!
//                                 .copyWith(
//                                     color: Theme.of(context)
//                                         .colorScheme
//                                         .onBackground),
//                           ),
//                         ],
//                       ),
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: SizedBox(
//                           width: screenWidth / 2,
//                           child: Text(
//                             menuItem.description ?? '',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyMedium!
//                                 .copyWith(
//                                     color: Theme.of(context)
//                                         .colorScheme
//                                         .onBackground),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
