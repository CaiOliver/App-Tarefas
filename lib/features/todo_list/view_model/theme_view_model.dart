import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeViewModel extends ChangeNotifier {
  final _box = Hive.box('settings');

  bool get isDark => _box.get('isDark', defaultValue: false);

  ThemeMode get themeMode => isDark ? ThemeMode.dark : ThemeMode.light;

  void changeTheme() {
    _box.put('isDark', !isDark);
    notifyListeners();
  }
}
