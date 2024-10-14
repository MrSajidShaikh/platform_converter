import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  bool isDark = false;
  SharedPreferences? sharedPreferences;

  ThemeData themeDark = ThemeData(
    tabBarTheme: const TabBarTheme(
      dividerColor: Colors.grey,
      indicatorColor: Colors.white,
    ),
    datePickerTheme: const DatePickerThemeData(),
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,
      onSurface: Colors.white,
    ),
  );

  CupertinoThemeData cupertinoThemeLight = const CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.black,
  );

  CupertinoThemeData cupertinoThemeDark = const CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: CupertinoColors.white,
  );

  ThemeData themeLight = ThemeData(
    tabBarTheme: const TabBarTheme(
      dividerColor: Colors.grey,
      indicatorColor: Colors.black,
    ),
    datePickerTheme: const DatePickerThemeData(),
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
      onSurface: Colors.black,
    ),
  );

  void toggleTheme() {
    isDark = !isDark;
    setSaveTheme(isDark);
    notifyListeners();
  }

  Future<void> setSaveTheme(bool value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setBool("theme", value);
  }

  ThemeController(bool value) {
    isDark = value;
  }
}