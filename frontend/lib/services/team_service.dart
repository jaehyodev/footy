import 'dart:convert';
import 'package:http/http.dart' as http;

class TeamService {
  // 특정 팀을 가져오는 메서드
  Future<Map<String, dynamic>> fetchTeamById(String teamId) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://port-0-footy-m415nzyb5a6ffceb.sel4.cloudtype.app/teams'),
        headers: {
          'Cache-Control': 'no-cache', // 캐시를 무효화하는 헤더 추가
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        // 팀 리스트에서 id가 teamId와 일치하는 팀을 찾음
        print(data['teams'].firstWhere((team) => team['id'] == teamId));
        return data['teams'].firstWhere((team) => team['id'] == teamId);
      } else {
        throw Exception('Failed to load team');
      }
    } catch (e) {
      throw Exception('Error fetching team: $e');
    }
  }

  // 특정 팀의 선수들을 가져오는 메서드
  Future<List<Map<String, dynamic>>> fetchSquad(String teamId) async {
    try {
      final response = await http.get(Uri.parse(
          'https://port-0-footy-m415nzyb5a6ffceb.sel4.cloudtype.app/players'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // players 배열에서 teamId가 맞는 선수만 필터링 후 List로 변환
        List<dynamic> players = data['players'];
        // players 리스트에서 teamId와 일치하는 선수만 필터링하고, Map으로 변환
        return players
            .where((player) => player['id'].startsWith(teamId))
            .map<Map<String, dynamic>>(
                (player) => player as Map<String, dynamic>)
            .toList(); // Iterable을 List로 변환
      } else {
        throw Exception('Failed to load players');
      }
    } catch (e) {
      throw Exception('Error fetching players: $e');
    }
  }
}
