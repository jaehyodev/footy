import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/player_in_korean.dart';
import 'package:http/http.dart' as http;

import 'package:frontend/models/squad_response.dart';

class TeamService {
  // 특정 팀을 가져오는 메서드 (한국어)
  Future<Map<String, dynamic>> fetchTeamInKorean(int teamId) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://port-0-footy-m415nzyb5a6ffceb.sel4.cloudtype.app/teams'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        // 팀 리스트에서 id가 teamId와 일치하는 팀을 찾음
        return data['teams'].firstWhere((team) => team['id'] == teamId);
      } else {
        throw Exception('Failed to load team');
      }
    } catch (e) {
      throw Exception('Error fetching team: $e');
    }
  }

  // 특정 팀의 선수들을 가져오는 메서드 (한국어)
  Future<List<Map<String, dynamic>>> fetchPlayersInKorean(int teamId) async {
    print("받은 팀 아이디:$teamId");

    final response = await http.get(Uri.parse(
        'https://port-0-footy-m415nzyb5a6ffceb.sel4.cloudtype.app/players'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // players 배열에서 teamId에 맞는 선수만 필터링
      List<dynamic> players = data['players']
          .where((player) => player['teamId'] == teamId) // teamId에 맞는 선수만 필터링
          .toList();

      // 선수들을 Map<String, dynamic> 형태로 리턴
      return players
          .map<Map<String, dynamic>>((player) => player as Map<String, dynamic>)
          .toList();
    } else {
      throw Exception('Failed to load players');
    }
  }

  // 특정 팀의 선수들을 가져오는 메서드 (영어)
  Future<SquadResponse?> fetchSquadInEnglish(int teamId) async {
    final String apiKey = dotenv.env['API_FOOTBALL_KEY'] ?? 'No API Key';
    final url = Uri.parse(
        'https://v3.football.api-sports.io/players/squads?team=$teamId');

    final response = await http.get(
      url,
      headers: {
        'x-rapidapi-host': 'v3.football.api-sports.io',
        'x-rapidapi-key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // JSON 데이터를 잘리지 않게 출력
      debugPrint(jsonEncode(data), wrapWidth: 1024); // 줄바꿈을 적용하여 출력

      // SquadResponse 객체로 변환하여 리턴
      return SquadResponse.fromJson(data['response'][0]);
    } else {
      print('Failed to fetch squad: ${response.statusCode}');
    }
    return null;
  }
}
