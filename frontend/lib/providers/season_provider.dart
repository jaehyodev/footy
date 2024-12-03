import 'package:flutter/material.dart';

class SeasonProvider extends ChangeNotifier {
  late int _selectedSeason;

  SeasonProvider() {
    _selectedSeason = DateTime.now().year;
  }

  int get selectedSeason => _selectedSeason;

  void updateSeason(int newSeason) {
    // 빌드가 끝난 후 상태를 초기화
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedSeason = newSeason;
      notifyListeners();
    });
  }
}
