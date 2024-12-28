import 'package:flutter/material.dart';

import 'package:frontend/models/team.dart';

class TeamProvider with ChangeNotifier {
  Team? _selectedTeam; // 팔로잉 화면에서 선택된 팀
  int _selectedIndex = 0; // 팀 화면에서 선택된 네비게이션 인덱스

  Team? get selectedTeam => _selectedTeam;
  int get selectedIndex => _selectedIndex;

  void selectTeam(Team team) {
    _selectedTeam = team;
    notifyListeners();
  }

  void clearTeam() {
    _selectedTeam = null;
    notifyListeners();
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
