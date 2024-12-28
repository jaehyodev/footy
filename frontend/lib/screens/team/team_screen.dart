import 'package:flutter/material.dart';
import 'package:frontend/screens/team/widgets/team_squad.dart';
import 'package:provider/provider.dart';

import 'package:frontend/providers/team_provider.dart';
import 'package:frontend/screens/team/widgets/team_header.dart';
import 'package:frontend/screens/team/widgets/team_navigation.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  Widget build(BuildContext context) {
    final team = Provider.of<TeamProvider>(context).selectedTeam;

    return Theme(
      data: Theme.of(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: team != null
              ? Color(int.parse('0xFF${team.color.substring(1)}'))
              : Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          leadingWidth: 40,
        ),
        body: const Column(
          children: [
            TeamHeader(),
            TeamNavigation(),
            TeamSquad(),
          ],
        ),
      ),
    );
  }
}
