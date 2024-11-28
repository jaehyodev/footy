import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  // final Function(int) onTap; // 탭 클릭 시 호출될 콜백 함수
  // final int selectedIndex; // 현재 선택된 인덱스

  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
        fontFamily: 'SCDream',
        fontWeight: FontWeight.w500, // 선택된 라벨의 폰트 설정
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: 'SCDream',
        fontWeight: FontWeight.w500, // 선택되지 않은 라벨의 폰트 설정
      ),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined), label: "경기"),
        BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined), label: "뉴스"),
        BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_outlined), label: "리그"),
        BottomNavigationBarItem(
            icon: Icon(Icons.star_outline_rounded), label: "팔로잉"),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined), label: "설정"),
      ],
    );
  }
}
