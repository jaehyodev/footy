// horizontal_calendar_style.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/date_provider.dart';
import '../../../themes/style.dart';

TextStyle getTextStyle(BuildContext context, DateTime date,
    {bool isBold = false}) {
  final selectedDate = context.watch<DateProvider>().selectedDateTime;

  // 연월일만 비교
  TextStyle baseStyle = TextStyle(
    color: (date.year == selectedDate.year &&
            date.month == selectedDate.month &&
            date.day == selectedDate.day)
        ? primary
        : textPrimary, // 기본 색상
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
  );

  return baseStyle;
}

BoxDecoration getButtonDecoration(BuildContext context, DateTime date) {
  final selectedDate = context.watch<DateProvider>().selectedDateTime;

  // 연월일만 비교하여 선택된 날짜에만 아래 선을 추가
  if (date.year == selectedDate.year &&
      date.month == selectedDate.month &&
      date.day == selectedDate.day) {
    return const BoxDecoration(
      border: Border(bottom: BorderSide(color: primary, width: 2)),
    );
  } else {
    return const BoxDecoration(); // 선택되지 않은 날짜는 선 없음
  }
}

String getDayOfWeek(DateTime date) {
  final now = DateTime.now();
  if (date.year == now.year && date.month == now.month && date.day == now.day) {
    return "오늘";
  }

  List<String> daysOfWeek = ['월', '화', '수', '목', '금', '토', '일'];
  return daysOfWeek[date.weekday - 1];
}
