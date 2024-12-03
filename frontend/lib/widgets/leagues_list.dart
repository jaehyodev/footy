import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/home/themes/leagues_list_styles.dart';
import '../models/league.dart';
import '../providers/league_provider.dart';

class LeaguesList extends StatefulWidget {
  final bool includesAll;

  const LeaguesList({
    super.key,
    required this.includesAll,
  });

  @override
  LeaguesListState createState() => LeaguesListState();
}

class LeaguesListState extends State<LeaguesList> {
  int _selectedIndex = 0;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 화면 전환할 때마다 초기화
    // 화면에 처음 들어왔을 때 한 번만 실행
    if (!_isInitialized) {
      if (widget.includesAll) {
        context.read<LeagueProvider>().resetSelectionForHome();
      } else {
        context.read<LeagueProvider>().resetSelectionForLeague();
      }
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // widget.includesAll 값에 따라 사용할 리스트를 결정
    // 홈 화면은 전체 리그를 포함
    // 리그 화면은 전체 리그를 포함하지 않음
    List<League> leaguesToShow = widget.includesAll
        ? context.watch<LeagueProvider>().leaguesIncludingAll
        : context.watch<LeagueProvider>().leaguesExcludingAll;

    return Container(
      color: LeaguesListStyles.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: leaguesToShow.asMap().entries.map((entry) {
              int index = entry.key;
              League league = entry.value;

              return Padding(
                padding: index == leaguesToShow.length - 1
                    ? EdgeInsets.zero // 마지막 버튼에는 여백을 주지 않음
                    : const EdgeInsets.only(right: 4.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    context.read<LeagueProvider>().updateLeague(
                          index,
                          league.name,
                          league.code,
                        );
                  },
                  style: index == _selectedIndex
                      ? LeaguesListStyles.selectedButtonStyle
                      : LeaguesListStyles.defaultButtonStyle,
                  child: Text(
                    league.name,
                    style: index == _selectedIndex
                        ? LeaguesListStyles.selectedTextStyle
                        : LeaguesListStyles.defaultTextStyle,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
