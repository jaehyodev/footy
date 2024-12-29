import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'package:frontend/models/squad_response.dart';
import 'package:frontend/providers/team_provider.dart';
import 'package:frontend/screens/team/widgets/team_person.dart';
import 'package:frontend/services/team_service.dart';

class TeamSquad extends StatefulWidget {
  const TeamSquad({super.key});

  @override
  State<TeamSquad> createState() => _TeamSquadState();
}

class _TeamSquadState extends State<TeamSquad> {
  final TeamService _teamService = TeamService();
  late Future<Map<String, List<dynamic>>> _squad;

  @override
  void initState() {
    super.initState();
    // 팀 데이터와 선수 데이터를 동시에 가져오기
    _squad = _fetchSquad();
  }

  Future<Map<String, List<dynamic>>> _fetchSquad() async {
    final selectedTeamId =
        Provider.of<TeamProvider>(context, listen: false).selectedTeam!.id;

    // 팀 정보 가져오기
    final team = await _teamService.fetchTeamByKorean(selectedTeamId);

    // 선수 정보 가져오기
    final List<Map<String, dynamic>> players =
        await _teamService.fetchPlayersByKorean(selectedTeamId);

    // 영어 API에서 선수 정보 가져오기
    final SquadResponse? squadResponse =
        await _teamService.fetchSquadByEnglish(selectedTeamId);

    // squad를 미리 초기화
    Map<String, List<dynamic>> squad = {
      '감독': [],
      '골키퍼': [],
      '수비수': [],
      '미드필더': [],
      '공격수': [],
    };

    // 팀 정보에서 감독 정보 추가
    squad['감독']!.add({
      'name': team['manager']['name'],
      'position': '감독',
      'countryName': team['manager']['countryName'],
      'countryCode': team['manager']['countryCode'],
    });

    // 선수 정보를 포지션별로 분류
    for (var player in players) {
      if (player['position'] == 'GK') {
        squad['골키퍼']!.add(player);
      } else if (player['position'] == 'DF') {
        squad['수비수']!.add(player);
      } else if (player['position'] == 'MF') {
        squad['미드필더']!.add(player);
      } else if (player['position'] == 'FW') {
        squad['공격수']!.add(player);
      }
    }

    // squadResponse에서 photo를 추가하여 player 데이터와 연결
    if (squadResponse != null) {
      for (var position in squad.keys) {
        for (var player in squad[position]!) {
          // squadResponse에서 photo 찾기
          final matchedPlayer = squadResponse.players.firstWhere(
            (p) => p.number == player['number'],
            orElse: () => Player(
              // player가 없을 경우 빈 Player 객체 반환
              id: 0, // 기본 값 설정
              name: '', // 기본 값 설정
              age: 0, // 기본 값 설정
              number: player['number'], // 해당 player의 번호를 사용
              position: '', // 기본 값 설정
              photo: '', // 기본 값 설정
            ),
          );

          // matchedPlayer가 photo를 가지면 해당 photo를 추가
          if (matchedPlayer.photo.isNotEmpty) {
            player['photo'] = matchedPlayer.photo;
          }
        }
      }
    }

    return squad;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, List<dynamic>>>(
      future: _squad,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('에러: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('데이터가 없습니다.'));
        }

        final squad = snapshot.data!;

        return Expanded(
          child: ListView.builder(
            itemCount: squad.length,
            itemBuilder: (context, index) {
              // position을 순차적으로 가져오기
              final position = squad.keys.elementAt(index);
              final players = squad[position]!;
              // _buildPositionCard를 사용하여 ListTile 대신 Card를 넣기
              return _buildPositionCard(position, players, index, squad.length);
            },
          ),
        );
      },
    );
  }

  Widget _buildPositionCard(
      String position, List<dynamic> players, int index, int squadLength) {
    return Card(
      margin: EdgeInsets.only(
        top: index == 0 ? 16 : 8, // 첫 번째 카드에는 위 margin 16을 주고, 나머지는 0
        left: 16,
        right: 16,
        bottom:
            index == squadLength - 1 ? 16 : 8, // 하단에만 margin 8을 주어 카드 간 간격을 유지
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              position,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(8),
            Column(
              children: players.map<Widget>((player) {
                return TeamPerson(player: player);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
