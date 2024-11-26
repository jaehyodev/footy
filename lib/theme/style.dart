import 'package:flutter/material.dart';

const Color primary = Color(0xFF1E90FF); // 메인 컬러 (블루)
const Color secondary = Color(0xFFFFC107); // 서브 컬러 (옐로우)
const Color background = Color(0xFFF5F5F5); // 배경색 (라이트 그레이)
const Color textPrimary = Color(0xFF222222); // 텍스트 메인 컬러 (다크 그레이)
const Color textSecondary = Color(0xFF888888); // 텍스트 서브 컬러 (라이트 그레이)
const Color whiteBackground = Colors.white; // 흰색 배경 추가

var theme = ThemeData(
  fontFamily: 'Hack',
  scaffoldBackgroundColor: whiteBackground,
  appBarTheme: const AppBarTheme(
      color: Colors.amber,
      actionsIconTheme: IconThemeData(color: Colors.blueGrey)),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: Colors.red,
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.blue),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: primary,
    unselectedItemColor: Colors.grey,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.blue),
  ),
);

// 바디 전체에 좌우 여백을 위한 스타일
const EdgeInsetsGeometry bodyPadding = EdgeInsets.symmetric(horizontal: 16.0);
