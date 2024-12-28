import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
  String _sortBy = 'publishedAt'; // 기본값은 최신순

  String get sortBy => _sortBy;

  void setSortBy(String value) {
    if (_sortBy != value) {
      _sortBy = value;
      notifyListeners(); // 값이 변경될 때 UI를 업데이트
    }
  }
}
