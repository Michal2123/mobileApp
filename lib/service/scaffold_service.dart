import 'package:flutter/material.dart';

class ScaffoldService with ChangeNotifier {
  bool _isDrawerOpen = false;
  bool get isDrawerOpen => _isDrawerOpen;
  static const String isDrawerOpenPropName = "isDrawerOpen";

  void openDrawer() {
    _isDrawerOpen = !_isDrawerOpen;
    notifyListeners();
  }

  void onDrawerChange(bool isOpen) {
    _isDrawerOpen = isOpen;
    notifyListeners();
  }
}
