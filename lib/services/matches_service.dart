import 'dart:convert';
import 'package:http/http.dart' as http;

class MatchesService {
  static const _apiToken = 'b895ff834aeb4f8880c26be76e13754c';
  static const _baseUrl = 'https://api.football-data.org/v4';

  static Future<List<Map<String, dynamic>>> fetchMatches(
      String leagueCode, DateTime dateTime) async {
    print("dateTime: $dateTime");

    // 해당일의 시작시간과 종료시간
    DateTime startOfDay = DateTime(dateTime.year, dateTime.month, dateTime.day);
    DateTime endOfDay =
        DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59);

    // api 호출에 사용할 하루 전 날짜 계산 (dateTime에서 1일 빼기)
    DateTime dateFrom = dateTime.subtract(const Duration(days: 1));
    // api 호출에 사용할 dateTime 그대로 (종료 시간은 dateTime)
    DateTime dateTo = dateTime;

    // 포맷팅된 날짜
    String formattedDateFrom =
        "${dateFrom.year}-${dateFrom.month.toString().padLeft(2, '0')}-${dateFrom.day.toString().padLeft(2, '0')}";
    String formattedDateTo =
        "${dateTo.year}-${dateTo.month.toString().padLeft(2, '0')}-${dateTo.day.toString().padLeft(2, '0')}";

    String url = leagueCode == "ALL"
        ? "$_baseUrl/matches?dateFrom=$formattedDateFrom&dateTo=$formattedDateTo"
        : "$_baseUrl/competitions/$leagueCode/matches?dateFrom=$formattedDateFrom&dateTo=$formattedDateTo";

    final response = await http.get(
      Uri.parse(url),
      headers: {'X-Auth-Token': _apiToken},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Map<String, dynamic>> matches =
          List<Map<String, dynamic>>.from(data['matches']);

      print(data);

      // 경기들의 'utcDate'가 startOfDay와 endOfDay 사이에 있는지 필터링
      return matches.where((match) {
        DateTime matchUtcDate = DateTime.parse(match['utcDate']);
        return (matchUtcDate.isAfter(startOfDay.toUtc()) ||
                matchUtcDate.isAtSameMomentAs(startOfDay.toUtc())) &&
            (matchUtcDate.isBefore(endOfDay.toUtc()) ||
                matchUtcDate.isAtSameMomentAs(endOfDay.toUtc()));
      }).toList();
    } else {
      throw Exception("Failed to load matches");
    }
  }
}
