import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier {
  Map<String, dynamic>? budgetRange;
  int colorIndex = -1;
  int storageIndex = -1;

  void setColor(int index) {
    colorIndex = index;
    notifyListeners();
  }

  void setStorage(int index) {
    storageIndex = index;
    notifyListeners();
  }

  void setBudget(Map<String, dynamic> item) {
    budgetRange = {
      'min': item['min'],
      'max': item['max'],
      'label': item['label'],
    };
    notifyListeners();
  }

  void clearFilters() {
    colorIndex = -1;
    storageIndex = -1;
    budgetRange = null;
    notifyListeners();
  }

  @override
  void dispose() {
    budgetRange = null;
    colorIndex = -1;
    storageIndex = -1;
    super.dispose();
  }
}
