import 'package:flutter/material.dart';

import 'package:frontend/models/league.dart';

class HomeLeagueProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  String _selectedLeagueName = '전체';
  String _selectedLeagueCode = 'ALL';

  int get selectedIndex => _selectedIndex;
  String get selectedLeagueName => _selectedLeagueName;
  String get selectedLeagueCode => _selectedLeagueCode;

  // 모든 리그 목록을 반환 (홈 화면)
  List<League> get leaguesIncludingAll => leagues;

  // 선택된 리그 업데이트 메서드
  void updateHomeLeague(int index, String name, String code) {
    _selectedIndex = index;
    _selectedLeagueName = name;
    _selectedLeagueCode = code;
    notifyListeners();
  }

  // 홈 화면으로 전환 시 상태를 초기화하는 메서드
  void resetHomeLeague() {
    // 빌드가 끝난 후 상태를 초기화
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedIndex = 0;
      _selectedLeagueName = '전체';
      _selectedLeagueCode = 'ALL';
      notifyListeners();
    });
  }
}
