import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  MaterialColor _currentTheme = Colors.red;

  MaterialColor get currentTheme => _currentTheme;

  void setTheme(String themeName) {
    _currentTheme = _getColorFromName(themeName);
    notifyListeners();
  }

  MaterialColor _getColorFromName(String themeName) {
    return switch (themeName) {
      'red' => Colors.red,
      'orange' => Colors.orange,
      'yellow' => Colors.yellow,
      'green' => Colors.green,
      'blue' => Colors.blue,
      'purple' => Colors.purple,
      _ => Colors.red,
    };
  }
}
