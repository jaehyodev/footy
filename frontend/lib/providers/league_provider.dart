import 'package:flutter/material.dart';

import 'package:frontend/models/league.dart';

class LeagueProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  String _selectedLeagueName = '전체';
  String _selectedLeagueCode = 'ALL';

  int get selectedIndex => _selectedIndex;
  String get selectedLeagueName => _selectedLeagueName;
  String get selectedLeagueCode => _selectedLeagueCode;

  // 모든 리그 목록을 반환 (홈 화면)
  List<League> get leaguesIncludingAll => leagues;

  // '전체'를 제외한 리그 목록을 반환 (리그 화면)
  List<League> get leaguesExcludingAll =>
      leagues.where((league) => league.name != '전체').toList();

  // 선택된 리그 업데이트 메서드
  void updateLeague(int index, String name, String code) {
    _selectedIndex = index;
    _selectedLeagueName = name;
    _selectedLeagueCode = code;
    notifyListeners();
  }

  // 홈 화면으로 전환 시 상태를 초기화하는 메서드
  void resetSelectionForHome() {
    // 빌드가 끝난 후 상태를 초기화
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedIndex = 0;
      _selectedLeagueName = '전체';
      _selectedLeagueCode = 'ALL';
      notifyListeners();
    });
  }

  // 리그 화면으로 전환 시 상태를 초기화하는 메서드
  void resetSelectionForLeague() {
    // 빌드가 끝난 후 상태를 초기화
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedIndex = 0;
      _selectedLeagueName = '프리미어리그';
      _selectedLeagueCode = 'PL';
      notifyListeners();
    });
  }
}
