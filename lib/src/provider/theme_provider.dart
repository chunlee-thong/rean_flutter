import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rean_flutter/src/services/local_storage.service.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkTheme = true;

  bool get isDarkTheme => _isDarkTheme;

  static ThemeProvider getProvider(BuildContext context, [bool listen = false]) => Provider.of<ThemeProvider>(
        context,
        listen: listen,
      );

  void initializeTheme() {
    bool isDark = LocalStorage.sharedPreferences.getBool(THEME_KEY) ?? false;
    _isDarkTheme = isDark;
    notifyListeners();
  }

  T themeValue<T>(T lightValue, T darkValue) {
    return isDarkTheme ? darkValue : lightValue;
  }

  void switchTheme([bool? isDarkTheme]) async {
    _isDarkTheme = isDarkTheme ?? !_isDarkTheme;
    notifyListeners();
    LocalStorage.sharedPreferences.setBool(THEME_KEY, _isDarkTheme);
  }
}
