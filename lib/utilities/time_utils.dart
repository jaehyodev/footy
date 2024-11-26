import 'package:intl/intl.dart';

class TimeUtils {
  // UTC 시간을 한국 시간으로 변환
  static DateTime convertToKoreanTime(DateTime utcTime) {
    int offset = TimeUtils.isDST(utcTime) ? 8 : 9;
    DateTime localTime = utcTime.add(Duration(hours: offset));
    return localTime;
  }

  // 일광절약시간제(DST) 적용 여부를 확인하는 함수
  static bool isDST(DateTime date) {
    // 3월 마지막 일요일부터 10월 마지막 일요일까지 일광절약시간제 적용
    DateTime startDST = _getLastSundayOfMonth(date.year, 3); // 3월 마지막 일요일
    DateTime endDST = _getLastSundayOfMonth(date.year, 10); // 10월 마지막 일요일

    return date.isAfter(startDST) && date.isBefore(endDST);
  }

  // 주어진 월의 마지막 일요일을 계산하는 함수
  static DateTime _getLastSundayOfMonth(int year, int month) {
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0); // 해당 월의 마지막 날짜
    int lastSundayOffset = lastDayOfMonth.weekday % 7; // 마지막 일요일까지의 차이
    return lastDayOfMonth.subtract(Duration(days: lastSundayOffset));
  }

  // 한국 시간 형식으로 출력
  static String formattedKoreanTime(DateTime localTime) {
    return DateFormat('HH:mm').format(localTime);
  }
}
