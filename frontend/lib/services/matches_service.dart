import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:frontend/models/league.dart';

/// MatchesService 클래스
/// 축구 경기 데이터를 api.football-data에서 가져오는 기능을 제공합니다.
/// 이 클래스는 주어진 리그 코드와 날짜를 기준으로 경기 일정 데이터를 불러와 처리합니다.
///
/// 주요 기능:
/// 1. 특정 리그 코드와 날짜를 기반으로 경기 일정을 API에서 가져옵니다.
/// 2. 리그 코드에 맞는 리그만 필터링하여 리스트를 제공합니다.
/// 3. 리그 코드 순서대로 경기 일정을 정렬하고, 리그 이름을 한글로 변환하여 반환합니다.
/// 4. 경기가 주어진 날짜 범위(하루)에 해당하는지 확인하고, 그에 맞는 경기만 반환합니다.
class MatchesService {
  static final String _apiKey = dotenv.env['FOOTBALL_API_KEY'] ?? 'No API Key';
  static const String _baseUrl = 'https://api.football-data.org/v4';

  /// 주어진 리그 코드와 날짜를 기반으로 경기 일정을 API에서 가져오는 메서드입니다.
  /// [leagueCode] : 경기 일정을 불러올 리그 코드 (예: "ALL", "PL", "BL1")
  /// [dateTime] : 경기 일정을 가져올 기준 날짜
  /// 반환값 : 주어진 날짜 범위에 맞는 경기 일정 리스트
  static Future<List<Map<String, dynamic>>> fetchMatches(
      String leagueCode, DateTime dateTime) async {
    print("matches_service.dart | leagueCode: $leagueCode");
    print("matches_service.dart | dateTime: $dateTime");

    // 중요! 시차로 인하여 하루 전의 경기 일정도 필요할 수 있습니다.
    // API 호출에 사용할 하루 전 날짜 계산 (dateTime에서 1일 빼기)
    DateTime dateFrom = dateTime.subtract(const Duration(days: 1));
    DateTime dateTo = dateTime;

    // 날짜를 "yyyy-MM-dd" 형식으로 포맷팅
    String formattedDateFrom =
        "${dateFrom.year}-${dateFrom.month.toString().padLeft(2, '0')}-${dateFrom.day.toString().padLeft(2, '0')}";
    String formattedDateTo =
        "${dateTo.year}-${dateTo.month.toString().padLeft(2, '0')}-${dateTo.day.toString().padLeft(2, '0')}";

    // API 호출 시 사용할 URL 결정 (모든 리그 또는 특정 리그)
    String url = leagueCode == "ALL"
        ? "$_baseUrl/matches?dateFrom=$formattedDateFrom&dateTo=$formattedDateTo"
        : "$_baseUrl/competitions/$leagueCode/matches?dateFrom=$formattedDateFrom&dateTo=$formattedDateTo";

    // HTTP 요청을 보내고 응답을 받음
    final http.Response response = await http.get(
      Uri.parse(url),
      headers: {'X-Auth-Token': _apiKey},
    );

    if (response.statusCode == 200) {
      // 응답 데이터를 JSON으로 파싱
      final Map<String, dynamic> data = jsonDecode(response.body);
      print('matches_service.dart | API 호출로부터 받은 경기 일정: $data');

      // 'matches' 배열을 리스트로 변환
      List<Map<String, dynamic>> matches =
          List<Map<String, dynamic>>.from(data['matches']);

      // 1. 리그 코드가 leagues 리스트에 포함된 리그만 필터링
      List<Map<String, dynamic>> filteredMatches = matches.where((match) {
        return leagues
            .any((league) => league.code == match['competition']['code']);
      }).toList();

      // 2. filteredMatches 리스트를 leagues 리스트의 code 순서대로 정렬
      filteredMatches.sort((a, b) {
        int indexA = leagues
            .indexWhere((league) => league.code == a['competition']['code']);
        int indexB = leagues
            .indexWhere((league) => league.code == b['competition']['code']);

        return indexA.compareTo(indexB);
      });

      // 3. 리그 이름을 한글로 변환
      List<Map<String, dynamic>> matchesWithKoreanLeagueNames =
          filteredMatches.map((match) {
        String leagueName = leagues
            .firstWhere((league) => league.code == match['competition']['code'])
            .name;
        // match의 리그 이름을 수정
        match['competition']['name'] = leagueName;
        return match;
      }).toList();

      // 4. 경기 일정 'utcDate'가 startOfDay와 endOfDay 사이에 있는 지 필터링
      return matchesWithKoreanLeagueNames.where((match) {
        // 해당일의 시작 시간과 종료 시간 계산 (예: 2024-12-02 00:00:00.000, 2024-12-02 23:59:59.000)
        DateTime startOfDay =
            DateTime(dateTime.year, dateTime.month, dateTime.day);
        DateTime endOfDay =
            DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59);

        // 경기 일정을 DateTime 객체로 변환
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
