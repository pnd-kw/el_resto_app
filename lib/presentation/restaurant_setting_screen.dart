import 'dart:math';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:retaste_app/model/restaurant.dart';
import 'package:retaste_app/repository/api.dart';
import 'package:retaste_app/repository/restaurant_data.dart';
import 'package:retaste_app/services/notification_service.dart';
import 'package:retaste_app/utils/notification_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantSettingScreen extends StatefulWidget {
  const RestaurantSettingScreen({super.key});

  @override
  State<RestaurantSettingScreen> createState() =>
      _RestaurantSettingScreenState();
}

class _RestaurantSettingScreenState extends State<RestaurantSettingScreen> {
  late NotificationSwitch _notificationSwitch;
  bool isOn = false;
  int alarmId = 1;

  @override
  void initState() {
    _initializeSwitch();
    super.initState();
  }

  Future<void> _initializeSwitch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _notificationSwitch = NotificationSwitch(
      prefs: prefs,
    );
    setState(() {
      isOn = _notificationSwitch.loadSwitchStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Restaurant Notification',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'enable restaurant notification',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              trailing: Switch(
                  value: isOn,
                  onChanged: (value) {
                    setState(() {
                      isOn = value;
                    });
                    _notificationSwitch.saveSwitchStatus(value);
                    if (value) {
                      final now = DateTime.now();
                      final scheduledTime =
                          DateTime(now.year, now.month, now.day, 11, 00);

                      AndroidAlarmManager.oneShot(
                        scheduledTime.difference(now),
                        alarmId,
                        fireAlarm,
                      );
                    } else {
                      AndroidAlarmManager.cancel(alarmId);
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

void fireAlarm() {
  showRandomRestaurantNotification();
}

Future<void> showRandomRestaurantNotification() async {
  final restaurants =
      await RestaurantData().fetchRestaurantData(baseUrl, getRestaurant);

  Random random = Random();
  int randomIndex = random.nextInt(restaurants.length);
  Restaurant randomRestaurant = restaurants[randomIndex];

  await NotificationService().showNotification(
    id: 0,
    title: randomRestaurant.name,
    body: randomRestaurant.description,
  );
}
