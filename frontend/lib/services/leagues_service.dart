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

      // 순위 데이터만 추출
      List<Map<String, dynamic>> standings =
          List<Map<String, dynamic>>.from(data['standings'][0]['table']);
      print(
          'leagies_service.dart | $season 시즌의 $leagueCode 리그 순위 정보: $standings');
      return standings;
    } else {
      throw Exception("Failed to load matches");
    }
  }
}
