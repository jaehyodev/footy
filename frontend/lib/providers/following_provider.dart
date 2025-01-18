import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FollowingProvider extends ChangeNotifier {
  // 상태 관리 필드
  bool isEditing = false; // 편집 모드 상태
  Set<int> followingTeams = {}; // 팔로잉 팀 목록

  FollowingProvider() {
    _loadFollowingTeams(); // 앱 시작 시 저장된 팔로잉 팀 목록을 로드
  }

  // 편집 모드 상태를 토글
  void toggleEditMode() {
    isEditing = !isEditing;
    notifyListeners(); // 상태 변경 알림
  }

  // 로컬 저장소에서 팔로잉 팀 목록 로드
  // Future<void> _loadFollowingTeams() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // 저장된 리스트를 불러와서 Set<int>로 변환
  //   List<String>? followingTeamsStringList =
  //       prefs.getStringList('followingTeams');
  //   followingTeams =
  //       followingTeamsStringList?.map((e) => int.tryParse(e) ?? 0).toSet() ??
  //           {};
  //   notifyListeners();
  // }

  // firestore에서 팔로잉 팀 목록 로드
  Future<void> _loadFollowingTeams() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .get();
      followingTeams = Set<int>.from(snapshot['followingTeams'] ?? []);
      notifyListeners();
    }
  }

  // 특정 팀의 팔로우 상태를 토글
  void toggleFollow(int teamId) async {
    if (followingTeams.contains(teamId)) {
      followingTeams.remove(teamId);
    } else {
      followingTeams.add(teamId);
    }
    await _saveFollowingTeams();
    notifyListeners();
  }

  // 로컬 저장소에 팔로잉 팀 목록 저장
  // Future<void> _saveFollowingTeams() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // Set<int>을 List<String>으로 변환하여 저장
  //   prefs.setStringList(
  //       'followingTeams', followingTeams.map((e) => e.toString()).toList());
  // }

  // firestore에 팔로잉 팀 목록 저장
  Future<void> _saveFollowingTeams() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .update({
          'followingTeams': followingTeams,
        });
        print('성공');
      }
    } catch (e) {
      print(e);
    }
  }

  // 팔로잉 팀 목록 반환
  Set<int> getFollowingTeams() {
    return followingTeams;
  }
}
