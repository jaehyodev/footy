import 'package:flutter/material.dart';

class TeamsList extends StatelessWidget {
  final List teams;

  const TeamsList({super.key, required this.teams});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: teams.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(teams[index]['name']), // 팀 이름 표시
          subtitle:
              Text(teams[index]['shortName'] ?? 'No short name'), // 팀의 줄임 이름
          leading: teams[index]['crest'] != null
              ? Image.network(teams[index]['crest']) // 팀의 크레스트(로고)
              : null,
        );
      },
    );
  }
}
