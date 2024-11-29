import 'package:flutter/material.dart';

class LeagueProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  String _selectedLeagueName = "전체";
  String _selectedLeagueCode = "ALL";

  int get selectedIndex => _selectedIndex;
  String get selectedLeagueName => _selectedLeagueName;
  String get selectedLeagueCode => _selectedLeagueCode;

  void updateLeague(int index, String name, String code) {
    _selectedIndex = index;
    _selectedLeagueName = name;
    _selectedLeagueCode = code;
    notifyListeners();
  }
}
