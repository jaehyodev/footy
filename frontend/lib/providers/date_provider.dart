import 'package:flutter/material.dart';

class DateProvider extends ChangeNotifier {
  late DateTime _selectedDateTime;

  DateProvider() {
    _selectedDateTime = DateTime.now();
  }

  DateTime get selectedDateTime => _selectedDateTime;

  void updateDateTime(DateTime newDateTime) {
    _selectedDateTime = newDateTime;
    notifyListeners();
  }
}
