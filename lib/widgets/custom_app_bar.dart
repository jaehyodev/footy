import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("MatchDay"),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(0), // 앱바의 하단 여백을 0으로 설정
        child: SizedBox(),
      ),
    );
  }

  // appbar의 높이 지정
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
