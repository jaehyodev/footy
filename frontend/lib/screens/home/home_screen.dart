import 'package:flutter/material.dart';
import 'package:frontend/widgets/home_leagues_list.dart';
import './widgets/horizontal_calendar.dart';
import 'package:frontend/screens/home/widgets/matches_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        HomeLeaguesList(),
        HorizontalCalendar(),
        MatchesList(),
      ],
    );
  }
}
