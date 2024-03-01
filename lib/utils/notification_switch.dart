import 'package:shared_preferences/shared_preferences.dart';

class NotificationSwitch {
  final SharedPreferences _prefs;
  late bool switchStatus;

  NotificationSwitch({
    required SharedPreferences prefs,
  }) : _prefs = prefs {
    switchStatus = _prefs.getBool('switchStatus') ?? false;
  }

  void saveSwitchStatus(bool status) {
    switchStatus = status;
    _prefs.setBool('switchStatus', status);
  }

  bool loadSwitchStatus() {
    return _prefs.getBool('switchStatus') ?? false;
  }
}
