import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContrastProvider with ChangeNotifier {
  bool _isHighContrast = false;

  bool get isHighContrast => _isHighContrast;

  void toggleContrast() async {
    _isHighContrast = !_isHighContrast;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('highContrast', _isHighContrast);
  }

  Future<void> loadContrast() async {
    final prefs = await SharedPreferences.getInstance();
    _isHighContrast = prefs.getBool('highContrast') ?? false;
    notifyListeners();
  }
}
