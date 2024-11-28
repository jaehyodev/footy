import 'package:flutter/material.dart';

const Color primary = Color(0xFF1E90FF);
const Color background = Color(0xFFF5F5F5);
const Color textPrimary = Color(0xFF222222);
const Color whiteBackground = Colors.white;

final ThemeData theme = ThemeData(
  fontFamily: 'Pretendard',
  scaffoldBackgroundColor: whiteBackground,
  appBarTheme: const AppBarTheme(
    color: primary,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: primary,
    unselectedItemColor: Colors.grey,
  ),
);

// 바디 전체 좌우 여백
const EdgeInsetsGeometry bodyPadding = EdgeInsets.symmetric(horizontal: 16.0);
