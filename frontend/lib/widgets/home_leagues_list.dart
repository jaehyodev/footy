import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:frontend/models/league.dart';
import 'package:frontend/providers/home_league_provider.dart';
import 'package:frontend/screens/home/themes/leagues_list_styles.dart';

class HomeLeaguesList extends StatefulWidget {
  const HomeLeaguesList({super.key});

  @override
  HomeLeaguesListState createState() => HomeLeaguesListState();
}

class HomeLeaguesListState extends State<HomeLeaguesList> {
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
      context.read<HomeLeagueProvider>().resetHomeLeague();
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<League> leaguesToShow =
        context.watch<HomeLeagueProvider>().leaguesIncludingAll;

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
                    ? EdgeInsets.zero
                    : const EdgeInsets.only(right: 4.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    context.read<HomeLeagueProvider>().updateHomeLeague(
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
