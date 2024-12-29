import 'package:flutter/material.dart';
import 'package:frontend/utils/loader_overlay.dart';
import 'package:provider/provider.dart';

import 'package:frontend/providers/league_league_provider.dart';
import 'package:frontend/providers/season_provider.dart';
import 'package:frontend/models/standing.dart';
import 'package:frontend/screens/league/widgets/standings_list_item.dart';
import 'package:frontend/services/leagues_service.dart';

class StandingsList extends StatefulWidget {
  const StandingsList({super.key});

  @override
  State<StandingsList> createState() => _StandingsListState();
}

class _StandingsListState extends State<StandingsList> {
  List<Map<String, dynamic>> standings = [];
  late String previousLeagueCode;
  late int previousSeason;

  @override
  void initState() {
    super.initState();
    final leagueCode = context.read<LeagueLeagueProvider>().selectedLeagueCode;
    final season = context.read<SeasonProvider>().selectedSeason;

    previousLeagueCode = leagueCode;
    previousSeason = season;

    fetchStandings(leagueCode, season);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final leagueCode = context.watch<LeagueLeagueProvider>().selectedLeagueCode;
    final season = context.watch<SeasonProvider>().selectedSeason;

    if (leagueCode != previousLeagueCode || season != previousSeason) {
      fetchStandings(leagueCode, season);
      previousLeagueCode = leagueCode;
      previousSeason = season;
    }
  }

  Future<void> fetchStandings(String leagueCode, int season) async {
    LoaderOverlay.show(context);
    try {
      final fetchedStandings =
          await LeaguesService.fetchLeague(leagueCode, season);
      if (mounted) {
        setState(() {
          standings = fetchedStandings;
        });
      }
    } catch (e) {
      print('standings_list.dart | 순위 데이터 가져오기 에러: $e');
    } finally {
      if (mounted) {
        LoaderOverlay.hide();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 순위 리스트 출력
    return Expanded(
      child: ListView.builder(
        itemCount: standings.length,
        itemBuilder: (context, index) {
          final standingData = standings[index];
          final standing = Standing.fromJson(standingData);
          return StandingsListItem(standing: standing);
        },
      ),
    );
  }
}
