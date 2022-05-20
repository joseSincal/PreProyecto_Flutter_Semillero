import 'package:flutter/material.dart';
import 'package:pre_proyecto_universales_chat/Utils/app_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static ThemeMode? _theme;

  Future<ThemeMode> getDefaultTheme() async {
    final String? savedTheme =
        await AppPreferences.shared.getString(AppPreferences.APP_THEME);
    if (savedTheme != null) {
      if (savedTheme == 'light') {
        return ThemeMode.light;
      } else if (savedTheme == 'dark') {
        return ThemeMode.dark;
      }
    }

    _theme = ThemeMode.system;
    return _theme!;
  }

  ThemeMode get getTheme => _theme!;

  set setTheme(ThemeMode theme) {
    _theme = theme;
    AppPreferences.shared
        .setString(AppPreferences.APP_THEME, theme.name);
    notifyListeners();
  }
}
