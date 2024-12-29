import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:frontend/models/manager.dart';

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

  // 특정 팀의 매니저를 가져오는 메서드 (영어)
  Future<Manager?> fetchManager(int teamId) async {
    final String apiKey = dotenv.env['API_FOOTBALL_KEY'] ?? 'No API Key';
    final url =
        Uri.parse('https://v3.football.api-sports.io/coachs?team=$teamId');

    final response = await http.get(
      url,
      headers: {
        'x-rapidapi-host': 'v3.football.api-sports.io',
        'x-rapidapi-key': apiKey,
      },
    );

    if (response.statusCode == 200) {
      // 응답이 성공적이면, JSON 데이터를 반환
      final data = json.decode(response.body);
      print("감독: ${data['response']}");
      // 감독 정보가 있는지 확인 후, 해당 정보를 반환
      if (data['response'] != null && data['response'].isNotEmpty) {
        return Manager.fromJson(data['response'][0]); // Coach 모델로 변환하여 반환
      } else {
        print('감독 정보를 찾을 수 없습니다.');
        return null;
      }
    } else {
      // 오류가 발생하면 null 반환
      print('API 요청 실패: ${response.statusCode}');
      return null;
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
