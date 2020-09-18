import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeProvider extends ChangeNotifier {
  bool isLightMode = false;

  bool get getMode => isLightMode;
  set setMode(bool newMode) {
    isLightMode = newMode;
    getCurrentStatusNavigationBarColor();
    notifyListeners();
  }

  getCurrentStatusNavigationBarColor() {
    if (isLightMode) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Color(0xFFFFFFFF),
          systemNavigationBarIconBrightness: Brightness.dark));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Color(0xFF26242e),
          systemNavigationBarIconBrightness: Brightness.light));
    }
  }

  ThemeData themeData() {
    return ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: isLightMode ? Colors.grey : Colors.grey,
        primaryColor: isLightMode ? Colors.white : Color(0xFF1E1F28),
        brightness: isLightMode ? Brightness.light : Brightness.dark,
        backgroundColor: isLightMode ? Color(0xFFFFFFFF) : Color(0xFF26242e),
        toggleableActiveColor: isLightMode ? Color(0xFFFFFFFF) : Color(0xFF34323d),
        scaffoldBackgroundColor:
            isLightMode ? Color(0xFFFFFFFF) : Color(0xFF26242e));
  }

}
