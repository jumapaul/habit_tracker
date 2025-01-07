import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const String START_DESTINATION = 'startDestination';

  static Future<void> saveStartDestination(bool isClicked) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(START_DESTINATION, isClicked);
  }

  static Future<bool> getStartDestination() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(START_DESTINATION) ?? false;
  }

  static Future<void> deleteStartDestination() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(START_DESTINATION);
  }
}
