import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontSizeProvider extends ChangeNotifier {
  int _fontSize = 16; // Default font size

  int get fontSize => _fontSize;

  Future<void> loadFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getInt('fontSize') ?? 16;
    notifyListeners(); // Notify listeners to rebuild UI
  }

  Future<void> setFontSize(int newSize) async {
    final prefs = await SharedPreferences.getInstance();
    _fontSize = newSize;
    await prefs.setInt('fontSize', newSize);
    notifyListeners(); // Notify listeners to rebuild UI
  }
}
