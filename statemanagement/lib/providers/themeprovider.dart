import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  int time = 60;
  int get getTime => time;
  set setTime(value) => time = value;

  decrementTime() {
    time--;
    notifyListeners();
  }
}
