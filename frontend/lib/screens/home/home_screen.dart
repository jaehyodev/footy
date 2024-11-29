import 'package:flutter/material.dart';
import './widgets/leagues_list.dart';

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
        LeaguesList(),
      ],
    );
  }
}
