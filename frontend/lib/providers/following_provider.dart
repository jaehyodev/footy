import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FollowingProvider extends ChangeNotifier {
  // 상태 관리 필드
  bool isEditing = false; // 편집 모드 상태
  Set<String> followingTeams = {}; // 팔로잉 팀 목록

  FollowingProvider() {
    _loadFollowingTeams(); // 앱 시작 시 저장된 팔로잉 팀 목록을 로드
  }

  // 편집 모드 상태를 토글
  void toggleEditMode() {
    isEditing = !isEditing;
    notifyListeners(); // 상태 변경 알림
  }

  // 로컬 저장소에서 팔로잉 팀 목록 로드
  Future<void> _loadFollowingTeams() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    followingTeams = prefs.getStringList('followingTeams')?.toSet() ?? {};
    notifyListeners(); // 초기 로드 시 UI 업데이트
  }

  // 특정 팀의 팔로우 상태를 토글
  void toggleFollow(String teamName) async {
    if (followingTeams.contains(teamName)) {
      followingTeams.remove(teamName); // 팔로우 해제
    } else {
      followingTeams.add(teamName); // 팔로우
    }
    await _saveFollowingTeams(); // 상태 저장
    notifyListeners(); // UI 업데이트
  }

  // 로컬 저장소에 팔로잉 팀 목록 저장
  Future<void> _saveFollowingTeams() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('followingTeams', followingTeams.toList());
  }

  // 팔로잉 팀 목록 반환
  Set<String> getFollowingTeams() {
    return followingTeams;
  }
}
