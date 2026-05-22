import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  int bottomNavigationIndex = 0;
 void setBottomNavigationIndex(int index) {
  bottomNavigationIndex = index;
  notifyListeners();
}
}
