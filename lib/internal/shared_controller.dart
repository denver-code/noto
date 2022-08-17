import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {
  static const IS_DARK_THEME = "isDarkTheme";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(IS_DARK_THEME, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(IS_DARK_THEME) ?? false;
  }
}
