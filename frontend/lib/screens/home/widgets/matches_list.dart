import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/models/league.dart';
import 'package:frontend/providers/date_provider.dart';
import 'package:frontend/providers/league_provider.dart';
import 'package:frontend/screens/home/widgets/matches_list_item.dart';
import 'package:frontend/services/matches_service.dart';

class MatchesList extends StatefulWidget {
  const MatchesList({super.key});

  @override
  State<MatchesList> createState() => _MatchesListState();
}

class _MatchesListState extends State<MatchesList> {
  bool isLoading = false;
  List<Map<String, dynamic>> matches = []; // 리그 및 날짜에 따라 경기 일정을 저장
  late String previousLeagueCode; // 이전 리그 코드
  late DateTime previousSelectedDate; // 이전 날짜
  Map<String, bool> expandedLeagues = {}; // 리그별 확장 상태 관리

  @override
  void initState() {
    super.initState();
    final leagueCode = context.read<LeagueProvider>().selectedLeagueCode;
    final selectedDate = context.read<DateProvider>().selectedDateTime;

    previousLeagueCode = leagueCode;
    previousSelectedDate = selectedDate;

    fetchMatches(leagueCode, selectedDate);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final leagueCode = context.watch<LeagueProvider>().selectedLeagueCode;
    final selectedDate = context.watch<DateProvider>().selectedDateTime;

    if (leagueCode != previousLeagueCode ||
        selectedDate != previousSelectedDate) {
      fetchMatches(leagueCode, selectedDate);
      previousLeagueCode = leagueCode;
      previousSelectedDate = selectedDate;
    }
  }

  Future<void> fetchMatches(String leagueCode, DateTime dateTime) async {
    setState(() => isLoading = true);
    try {
      final fetchedMatches =
          await MatchesService.fetchMatches(leagueCode, dateTime);
      if (mounted) {
        // 위젯이 트리에 있으면 setState 호출
        setState(() => matches = fetchedMatches);
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      if (mounted) {
        // 위젯이 트리에 있으면 setState 호출
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // leagueCode와 matches 상태를 가져옵니다.
    final leagueCode = context.watch<LeagueProvider>().selectedLeagueCode;

    // matches가 비어있고 로딩 중이지 않다면 "경기가 없습니다." 표시
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (matches.isEmpty) {
      return const Center(child: Text("경기가 없습니다."));
    }

    // leagueCode가 "ALL"인 경우와 그렇지 않은 경우에 따른 화면 분기
    if (leagueCode == "ALL") {
      return buildAllLeaguesView();
    } else {
      return buildSpecificLeagueView();
    }
  }

  Widget buildAllLeaguesView() {
    // 리그별로 경기를 그룹화
    final groupedMatches = <String, List<Map<String, dynamic>>>{};
    for (var match in matches) {
      final leagueName = match['competition']['name'];
      if (!groupedMatches.containsKey(leagueName)) {
        groupedMatches[leagueName] = [];
      }
      groupedMatches[leagueName]!.add(match);
    }

    // 리그별로 출력
    return Expanded(
      child: ListView.builder(
        itemCount: groupedMatches.length,
        itemBuilder: (context, index) {
          final leagueName = groupedMatches.keys.elementAt(index);
          final leagueMatches = groupedMatches[leagueName]!;
          final isExpanded = expandedLeagues[leagueName] ?? false;

          // 리그 아이템
          return Container(
            margin: const EdgeInsets.only(top: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(leagueName),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "${leagueMatches.length}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                  onTap: () {
                    setState(() {
                      expandedLeagues[leagueName] = !isExpanded;
                    });
                  },
                ),

                // 리그 안의 경기 일정 아이템
                if (isExpanded)
                  Column(
                    children: [
                      const Divider(
                        color: Color(0xFFE0E0E0),
                        thickness: 0.5,
                        height: 0.5,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: leagueMatches.length,
                        itemBuilder: (context, index) {
                          final match = leagueMatches[index];
                          return Column(
                            children: [
                              MatchesListItem(match: match),
                              if (index < leagueMatches.length - 1)
                                const Divider(
                                  color: Color(0xFFE0E0E0),
                                  thickness: 0.5,
                                  height: 0.5,
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildSpecificLeagueView() {
    return Expanded(
      // Expanded로 감싸서 Column에 충분한 공간을 제공
      child: ListView.builder(
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final match = matches[index];
          return Column(
            children: [
              MatchesListItem(match: match),
              if (index < matches.length - 1)
                const Divider(
                  color: Color(0xFFE0E0E0),
                  thickness: 0.5,
                  height: 0.5,
                ),
            ],
          );
        },
      ),
    );
  }
}
