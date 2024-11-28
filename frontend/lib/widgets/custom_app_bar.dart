import 'package:flutter/material.dart';
import 'package:frontend/data/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // 아이콘과 타이틀을 Row로 배치하여 하나의 버튼처럼 만들기
      title: GestureDetector(
        onTap: () {
          // 아이콘과 타이틀을 클릭할 때 동일한 동작
          _onAppBarPressed(context);
        },
        child: const Row(
          children: [
            Icon(Icons.sports_soccer), // 축구공 아이콘
            SizedBox(width: 8), // 아이콘과 타이틀 사이에 간격 추가
            Text(
              Constants.appName,
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(0), // 앱바의 하단 여백을 0으로 설정
        child: SizedBox(),
      ),
    );
  }

  // 클릭 시 실행될 동작을 하나의 메소드로 통합
  void _onAppBarPressed(BuildContext context) {
    // 아이콘과 타이틀이 클릭될 때 동일한 동작
    print("custom_app_bar.dart | 홈버튼이 클릭되었습니다.");
    // 홈 화면으로 이동
  }

  // appbar의 높이 지정
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
