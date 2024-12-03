import 'package:flutter/material.dart';
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
      ],
    );
  }
}
