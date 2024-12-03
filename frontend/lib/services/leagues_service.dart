import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class LeaguesService {
  static final String _apiKey = dotenv.env['FOOTBALL_API_KEY'] ?? 'No API Key';
  static const String _baseUrl = 'https://api.football-data.org/v4';

  static Future<List<Map<String, dynamic>>> fetchLeague(
      String leagueCode, int season) async {
    print('leagues_service.dart | leagueCode: $leagueCode, season: $season');

    // API 호출 시 사용할 URL (특정 리그)
    String url = '$_baseUrl/competitions/$leagueCode/standings?season=$season';

    // HTTP 요청을 보내고 응답을 받음
    final http.Response response = await http.get(
      Uri.parse(url),
      headers: {'X-Auth-Token': _apiKey},
    );

    if (response.statusCode == 200) {
      // 응답 데이터를 JSON으로 파싱
      final Map<String, dynamic> data = jsonDecode(response.body);
      // print('leagues_service.dart | API 호출로부터 받은 리그 순위: $data');

      // 'matches' 배열을 리스트로 변환
      List<Map<String, dynamic>> leaguesList =
          List<Map<String, dynamic>>.from(data['season']);
      return leaguesList;
    } else {
      throw Exception("Failed to load matches");
    }
  }
}

// '전체' 항목을 제외하고 리그 목록을 반환
// List<League> getLeagues(List<League> leagues, bool includeAll) {
//   if (includeAll) {
//     return leagues; // 전체 포함
//   } else {
//     return leagues.where((league) => league.name != '전체').toList(); // 전체 제외
//   }
// }
