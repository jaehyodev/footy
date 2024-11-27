import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlayersService {
  static final String _apiKey = dotenv.env['FOOTBALL_API_KEY'] ?? 'No API Key';
  static const String _baseUrl = 'https://api.football-data.org/v4/players';

  // 선수 가져오기 함수
  Future<void> fetchPlayer() async {
    print("함수 실행");
    final response = await http.get(
      Uri.parse('$_baseUrl/44'), // 여기서 44는 예시 선수 ID입니다
      headers: {'X-Auth-Token': _apiKey},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("선수 데이터: $data"); // 선수 데이터 출력
    } else {
      print('API 호출 실패: ${response.statusCode}');
    }
  }
}
