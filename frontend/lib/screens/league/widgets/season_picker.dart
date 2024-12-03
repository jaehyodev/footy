import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:frontend/providers/season_provider.dart';
import 'package:frontend/services/leagues_service.dart';

class SeasonPicker extends StatefulWidget {
  const SeasonPicker({super.key});

  @override
  State<SeasonPicker> createState() => _SeasonPickerState();
}

class _SeasonPickerState extends State<SeasonPicker> {
  bool isLoading = false;
  late int _season;

  @override
  void initState() {
    super.initState();
    final selectedSeason = context.read<SeasonProvider>().selectedSeason;
    _season = selectedSeason;
    fetchLeague('PL', selectedSeason);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 화면이 다시 돌아왔을 때, selectedSeason이 올해 연도인지 확인
    final selectedSeason = context.read<SeasonProvider>().selectedSeason;
    if (selectedSeason != DateTime.now().year) {
      // 현재 연도로 업데이트
      context.read<SeasonProvider>().updateSeason(DateTime.now().year);
      _season = DateTime.now().year;
      fetchLeague('PL', _season);
    }
  }

  Future<void> fetchLeague(String leagueCode, int selectedSeason) async {
    if (mounted) {
      setState(() => isLoading = true); // mounted 확인 후 호출
    }
    try {
      print('season_picker.dart | season: $selectedSeason');
      final data = await LeaguesService.fetchLeague(leagueCode, selectedSeason);
      print(
          'season_picker.dart | $selectedSeason 시즌의 $leagueCode 리그 정보: $data');
    } catch (e) {
      print(
          'season_picker.dart | $selectedSeason 시즌의 $leagueCode 리그 정보 불러오기 에러: $e');
    } finally {
      if (mounted) {
        setState(() => isLoading = false); // mounted 확인 후 호출
      }
    }
  }

  // 이전 시즌으로 이동
  void _previousSeason() {
    setState(() {
      final currentSeason = context.read<SeasonProvider>().selectedSeason;
      _season = currentSeason - 1;
      context.read<SeasonProvider>().updateSeason(_season);
      fetchLeague('PL', _season);
    });
  }

  // 이후 시즌으로 이동
  void _nextSeason() {
    setState(() {
      final currentSeason = context.read<SeasonProvider>().selectedSeason;
      _season = currentSeason + 1;
      context.read<SeasonProvider>().updateSeason(_season);
      fetchLeague('PL', _season);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _previousSeason,
              icon: const Icon(Icons.keyboard_arrow_left),
            ),
            Text('$_season/${_season + 1}'),
            IconButton(
              onPressed: _season >= DateTime.now().year ? null : _nextSeason,
              icon: const Icon(Icons.keyboard_arrow_right),
            ),
          ],
        )
      ],
    );
  }
}
