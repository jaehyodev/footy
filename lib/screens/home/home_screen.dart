import 'package:flutter/material.dart';
import 'widgets/matches_list.dart';
import 'widgets/leagues_list.dart';
import 'widgets/horizontal_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void handleDateSelected(DateTime selectedDate) {
    print("home_screen.dart | 선택된 날짜: $selectedDate");
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        LeaguesList(),
        HorizontalCalendar(),
        MatchesList(),
      ],
    );
  }
}
