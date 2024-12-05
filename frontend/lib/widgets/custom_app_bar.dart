import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // 앱바 타이틀
  final String title;
  // 홈 화면인지 여부를 판단하는 변수
  final bool isHomePage;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.isHomePage,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // 아이콘과 타이틀을 Row로 배치하여 하나의 버튼처럼 만들기
      title: GestureDetector(
        onTap: () {
          // 아이콘과 타이틀을 클릭할 때 동일한 동작
          _onAppBarPressed(context);
        },
        child: Row(
          children: [
            // 홈 화면일 때만 축구공 아이콘을 표시
            if (isHomePage) const Icon(Icons.sports_soccer),
            if (isHomePage) const Gap(8),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
      bottom: const PreferredSize(
        // 앱바의 하단 여백을 0으로 설정
        preferredSize: Size.fromHeight(0),
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
