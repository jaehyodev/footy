import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/home_league_provider.dart';
import 'package:frontend/providers/date_provider.dart';
import 'package:frontend/screens/home/widgets/matches_list_item.dart';
import 'package:frontend/services/matches_service.dart';
import 'package:frontend/utils/loader_overlay.dart';

class MatchesList extends StatefulWidget {
  const MatchesList({super.key});

  @override
  State<MatchesList> createState() => _MatchesListState();
}

class _MatchesListState extends State<MatchesList> {
  bool isLoading = false;
  List<Map<String, dynamic>> matches = [];
  late String previousLeagueCode;
  late DateTime previousSelectedDate;
  Map<String, bool> expandedLeagues = {};

  @override
  void initState() {
    super.initState();
    final leagueCode = context.read<HomeLeagueProvider>().selectedLeagueCode;
    final selectedDate = context.read<DateProvider>().selectedDateTime;

    previousLeagueCode = leagueCode;
    previousSelectedDate = selectedDate;

    fetchMatches(leagueCode, selectedDate);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final leagueCode = context.watch<HomeLeagueProvider>().selectedLeagueCode;
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
    LoaderOverlay.show(context); // 로딩 표시
    try {
      final fetchedMatches =
          await MatchesService.fetchMatches(leagueCode, dateTime);
      if (mounted) {
        setState(() => matches = fetchedMatches);
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
        LoaderOverlay.hide(); // 로딩 숨김
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final leagueCode = context.watch<HomeLeagueProvider>().selectedLeagueCode;

    if (matches.isEmpty && !isLoading) {
      return const Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("경기가 없습니다."),
          ],
        ),
      );
    }

    if (leagueCode == "ALL") {
      return buildAllLeaguesView();
    } else if (!isLoading) {
      return buildSpecificLeagueView();
    } else {
      return const Text('');
    }
  }

  Widget buildAllLeaguesView() {
    final groupedMatches = <String, List<Map<String, dynamic>>>{};
    for (var match in matches) {
      final leagueName = match['competition']['name'];
      if (!groupedMatches.containsKey(leagueName)) {
        groupedMatches[leagueName] = [];
      }
      groupedMatches[leagueName]!.add(match);
    }

    return Expanded(
      child: ListView.builder(
        itemCount: groupedMatches.length,
        itemBuilder: (context, index) {
          final leagueName = groupedMatches.keys.elementAt(index);
          final leagueMatches = groupedMatches[leagueName]!;
          final isExpanded = expandedLeagues[leagueName] ?? false;

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
