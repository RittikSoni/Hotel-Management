import 'package:flutter/material.dart';
import 'package:hotel_management/constant/kstrings.dart';

import 'package:shared_preferences/shared_preferences.dart';

/// To toggle dark, light mode:
/// e.g.
/// ```dart
///   final themeProvider = Provider.of<KThemeProvider>(context);
///   themeProvider.toggleTheme();
/// ```
class KThemeProvider extends ChangeNotifier {
  /// This will get called at initial and check the theme you've currently stored.
  /// and update the theme initially.
  KThemeProvider() {
    getThemeAtInit();
  }

  getThemeAtInit() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isDarkTheme = sharedPreferences.getBool(KPrefsKeys.isDarkTheme);
    if (isDarkTheme != null && isDarkTheme) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme() async {
    themeMode = !isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(
      KPrefsKeys.isDarkTheme,
      themeMode == ThemeMode.dark,
    );
  }

  void reset() {
    themeMode = ThemeMode.light;
    notifyListeners();
  }
}
