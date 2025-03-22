import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontSizeProvider with ChangeNotifier {
  double _fontSize = 16.0; // Default font size
  static const double defaultFontSize = 16.0; // Define a constant for default

  double get fontSize => _fontSize;

  bool get isSizeIncreased =>
      _fontSize > defaultFontSize; // Determine if increased

  void setFontSize(double newSize) async {
    _fontSize = newSize;
    notifyListeners();

    // Save preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSize', newSize);
  }

  Future<void> loadFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getDouble('fontSize') ?? defaultFontSize;
    notifyListeners();
  }
}
