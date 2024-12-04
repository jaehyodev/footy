import 'package:flutter/material.dart';

import 'package:frontend/screens/league/widgets/season_picker.dart';
import 'package:frontend/screens/league/widgets/standings_label.dart';
import 'package:frontend/screens/league/widgets/standings_list.dart';
import 'package:frontend/widgets/leagues_list.dart';

class LeagueScreen extends StatefulWidget {
  const LeagueScreen({super.key});

  @override
  State<LeagueScreen> createState() => LeagueScreenState();
}

class LeagueScreenState extends State<LeagueScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        LeaguesList(includesAll: false),
        SeasonPicker(),
        StandingsLabel(),
        StandingsList(),
      ],
    );
  }
}
