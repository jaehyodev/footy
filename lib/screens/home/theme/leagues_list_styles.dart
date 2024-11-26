import 'package:flutter/material.dart';

class LeaguesListStyles {
  // 배경색 정의
  static const Color backgroundColor = Colors.white;

  // 기본 버튼 스타일 정의
  static ButtonStyle defaultButtonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(
        horizontal: 12, vertical: 6), // 내부 패딩을 0으로 설정
    backgroundColor: Colors.white, // 기본 배경 색 (흰색)
    minimumSize: const Size(56, 28),
    side: const BorderSide(color: Colors.grey), // 테두리 색 (검은색)
  );

  // 선택된 버튼 스타일 정의
  static ButtonStyle selectedButtonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(
        horizontal: 12, vertical: 6), // 내부 패딩을 0으로 설정
    backgroundColor: Colors.lightBlue, // 선택된 버튼 배경 (하늘색)
    minimumSize: const Size(56, 28),
    side: const BorderSide(color: Colors.grey), // 테두리 색 (검은색)
  );

  // 기본 텍스트 스타일 정의
  static TextStyle defaultTextStyle = const TextStyle(
    fontSize: 12.0,
    color: Colors.black, // 기본 글씨 색 (검은색)
  );

  // 선택된 텍스트 스타일 정의
  static TextStyle selectedTextStyle = const TextStyle(
    fontSize: 12.0,
    color: Colors.white, // 선택된 버튼 글씨 색 (흰색)
  );
}
