import 'package:intl/intl.dart';

class TimeUtils {
  // UTC 시간을 한국 시간으로 변환
  static DateTime convertToKoreanTime(DateTime utcTime) {
    // 한국은 일광절약시간제(DST)를 사용하지 않으므로 항상 UTC +9시간
    DateTime localTime = utcTime.add(const Duration(hours: 9));
    return localTime;
  }

  // 일광절약시간제(DST) 적용 여부를 확인하는 함수
  // 외국 시간을 위해 만들었지만 현재 사용하지 않음
  static bool isDST(DateTime date) {
    // 3월 마지막 일요일부터 10월 마지막 일요일까지 일광절약시간제 적용
    DateTime startDST = _getLastSundayOfMonth(date.year, 3); // 3월 마지막 일요일
    DateTime endDST = _getLastSundayOfMonth(date.year, 10); // 10월 마지막 일요일

    return date.isAfter(startDST) && date.isBefore(endDST);
  }

  // 주어진 월의 마지막 일요일을 계산하는 함수
  // 홈 화면의 달력에서 사용
  static DateTime _getLastSundayOfMonth(int year, int month) {
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0); // 해당 월의 마지막 날짜
    int lastSundayOffset = lastDayOfMonth.weekday % 7; // 마지막 일요일까지의 차이
    return lastDayOfMonth.subtract(Duration(days: lastSundayOffset));
  }

  // 한국 시간 형식으로 출력
  static String formattedKoreanTime(DateTime localTime) {
    return DateFormat('HH:mm').format(localTime);
  }

  // 시간을 비교하여 "몇 분 전", "몇 시간 전" 형식으로 반환
  // 뉴스 화면에서 사용
  static String timeAgo(DateTime utcTime) {
    DateTime koreanTime = convertToKoreanTime(utcTime);
    final now = DateTime.now();
    final difference = now.difference(koreanTime);

    if (difference.inMinutes < 1) {
      return "방금 전"; // 1분 미만
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}분 전"; // 1분 이상 1시간 미만
    } else if (difference.inHours < 24) {
      return "${difference.inHours}시간 전"; // 1시간 이상 24시간 미만
    } else if (difference.inDays < 30) {
      return "${difference.inDays}일 전"; // 1일 이상 30일 미만
    } else if (difference.inDays < 365) {
      return "${(difference.inDays / 30).floor()}개월 전"; // 1개월 이상 1년 미만
    } else {
      return "${(difference.inDays / 365).floor()}년 전"; // 1년 이상
    }
  }
}
