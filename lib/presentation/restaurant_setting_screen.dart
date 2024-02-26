import 'package:flutter/material.dart';
import 'package:retaste_app/services/notification_service.dart';

class RestaurantSettingScreen extends StatelessWidget {
  const RestaurantSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            NotificationService()
                .showNotification(title: 'Sample title', body: 'It works!');
          },
          child: const Text('Show notifications'),
        ),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      //   child: ListTile(
      //     title: Text(
      //       'Restaurant Notification',
      //       style: Theme.of(context)
      //           .textTheme
      //           .titleLarge!
      //           .copyWith(color: Theme.of(context).colorScheme.onBackground),
      //     ),
      //     subtitle: Text(
      //       'enable restaurant notification',
      //       style: Theme.of(context)
      //           .textTheme
      //           .bodyMedium!
      //           .copyWith(color: Theme.of(context).colorScheme.onBackground),
      //     ),
      //     trailing: Switch(value: true, onChanged: (value) {}),
      //   ),
      // ),
    );
  }
}
