import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // 선택된 탭과 선택되지 않은 탭의 너비를 동일하게 설정
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      currentIndex: selectedIndex,
      onTap: onTap,
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
