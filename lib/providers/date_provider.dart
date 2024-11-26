import 'package:flutter/material.dart';

class DateProvider extends ChangeNotifier {
  late DateTime _selectedDateTime;

  DateProvider() {
    _selectedDateTime = DateTime.now();
  }

  // 현재 선택된 날짜를 가져오기 위한 getter
  DateTime get selectedDateTime => _selectedDateTime;

  // 날짜를 업데이트하고 상태 변경을 알림
  void updateDateTime(DateTime newDateTime) {
    _selectedDateTime = newDateTime;
    notifyListeners(); // 상태 변경 알림
  }
}
