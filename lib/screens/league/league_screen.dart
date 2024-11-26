import 'package:flutter/material.dart';
import '../../services/leagues_service.dart';
import './widgets/teams_list.dart';

class LeagueScreen extends StatefulWidget {
  const LeagueScreen({super.key});

  @override
  _LeagueScreenState createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen> {
  List leagues = [];
  List teams = [];
  bool isLoading = true;
  final LeaguesService leaguesService = LeaguesService();

  @override
  void initState() {
    super.initState();
    fetchLeagues();
  }

  // 리그 목록을 가져오는 함수
  Future<void> fetchLeagues() async {
    try {
      final leagueList = await leaguesService.fetchLeagues();
      setState(() {
        leagues = leagueList;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  // 특정 리그에 속한 팀을 가져오는 함수
  Future<void> fetchTeams(String leagueCode) async {
    try {
      final teamList = await leaguesService.fetchTeams(leagueCode);
      setState(() {
        teams = teamList;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Football Leagues'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // 리그 목록 로딩 중일 때
          : ListView.builder(
              itemCount: leagues.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(leagues[index]['name']),
                  onTap: () {
                    fetchTeams(leagues[index]['code']); // 리그 클릭 시 팀 목록 불러오기
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('${leagues[index]['name']} Teams'),
                        content: teams.isEmpty
                            ? const CircularProgressIndicator()
                            : TeamsList(teams: teams), // TeamsList로 팀 목록 표시
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
