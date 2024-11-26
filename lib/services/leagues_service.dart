import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LeaguesService {
  static final String _apiKey = dotenv.env['FOOTBALL_API_KEY'] ?? 'No API Key';
  static const String _baseUrl =
      'https://api.football-data.org/v4/competitions';

  // 리그 목록을 가져오는 함수
  Future<List> fetchLeagues() async {
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {'X-Auth-Token': _apiKey},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['competitions']; // 리그 목록 반환
    } else {
      throw Exception('Failed to load leagues');
    }
  }

  // 특정 리그에 속한 팀을 가져오는 함수
  Future<List> fetchTeams(String leagueCode) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$leagueCode/teams'),
      headers: {'X-Auth-Token': _apiKey},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['teams']; // 팀 목록 반환
    } else {
      throw Exception('Failed to load teams');
    }
  }
}
