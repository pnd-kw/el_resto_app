import 'dart:math';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retaste_app/bloc/restaurant_bloc.dart';
import 'package:retaste_app/model/restaurant.dart';
import 'package:retaste_app/services/notification_service.dart';

class RestaurantSettingScreen extends StatefulWidget {
  const RestaurantSettingScreen({super.key});

  @override
  State<RestaurantSettingScreen> createState() =>
      _RestaurantSettingScreenState();
}

class _RestaurantSettingScreenState extends State<RestaurantSettingScreen> {
  String randomRestaurantName = "";
  bool isOn = false;
  int alarmId = 1;

  @override
  Widget build(BuildContext context) {
    final restaurantBloc = context.watch<RestaurantBloc>();
    // final screenHeight = MediaQuery.of(context).size.height;

    // String name = '';
    if (restaurantBloc.state is RestaurantLoaded) {
      List<Restaurant> restaurants =
          (restaurantBloc.state as RestaurantLoaded).restaurants;

      Random random = Random();
      int randomIndex = random.nextInt(restaurants.length);

      Restaurant randomRestaurant = restaurants[randomIndex];

      randomRestaurantName = randomRestaurant.name;
      print(randomRestaurantName);
    }

    void restaurantAlarm() {
      print('Today restaurant is $randomRestaurantName');
      print('Alarm Fired at ${DateTime.now()}');
    }

    // void fireAlarm() {
    //   print('Alarm Fired at ${DateTime.now()}');
    // }

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
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       NotificationService()
      //           .showNotification(title: 'Sample title', body: 'It works!');
      //     },
      //     child: const Text('Show notifications'),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: ListTile(
          title: Text(
            'Restaurant Notification',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          subtitle: Text(
            'enable restaurant notification',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          trailing: Switch(
              value: isOn,
              onChanged: (value) {
                setState(() {
                  isOn = value;
                });
                if (isOn) {
                  AndroidAlarmManager.oneShot(
                      const Duration(seconds: 2), alarmId, fireAlarm);
                  print('Alarm set successfully.');
                  // final now = DateTime.now();
                  // final scheduledTime =
                  //     DateTime(now.year, now.month, now.day, 22, 0);

                  // AndroidAlarmManager.oneShot(
                  //     scheduledTime.difference(now), alarmId, popRestaurant,
                  //     exact: true, wakeup: true);
                } else {
                  AndroidAlarmManager.cancel(alarmId);
                  print('Alarm canceled successfully.');
                }
              }),
        ),
      ),
    );
  }
}

void fireAlarm() {
  print('Alarm Fired at ${DateTime.now()}');
  NotificationService()
      .showNotification(title: 'Sample title', body: 'it Works!');
}
