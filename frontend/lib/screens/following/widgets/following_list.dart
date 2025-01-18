import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/team.dart';
import 'package:frontend/screens/team/team_screen.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'package:frontend/data/constants.dart';
import 'package:frontend/providers/following_provider.dart';
import 'package:frontend/providers/team_provider.dart';

class FollowingList extends StatefulWidget {
  const FollowingList({super.key});

  @override
  State<FollowingList> createState() => _FollowingListState();
}

class _FollowingListState extends State<FollowingList> {
  @override
  Widget build(BuildContext context) {
    final followingProvider = Provider.of<FollowingProvider>(context);

    return Expanded(
      child: ListView.builder(
        itemCount: followingProvider.followingTeams.length,
        itemBuilder: (context, index) {
          // Set을 List로 변환하여 인덱스를 사용할 수 있도록 함
          List<int> teamIdList = followingProvider.followingTeams.toList();
          final teamId = teamIdList[index];

          // 팀 객체를 얻기 위한 방법 (orElse 추가하여 조건에 맞는 팀이 없을 경우 기본값 처리)
          final team = Constants.teams.firstWhere(
            (team) => team.id == teamId,
            orElse: () => Team(
                id: 0,
                tla: 'Unknown',
                name: 'Unknown Team',
                shortName: 'Unknown Team',
                country: 'Unknown',
                color: 'Unknown',
                logo: 'assets/placeholder.png'), // 기본값 설정
          );

          return Container(
            margin: const EdgeInsets.only(top: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              leading: followingProvider.isEditing
                  ? IconButton(
                      icon: const Icon(Icons.remove_circle_outline,
                          color: Colors.red),
                      onPressed: () {
                        followingProvider.toggleFollow(team.id); // 팀 삭제 처리
                      },
                    )
                  : null,
              title: Row(
                children: [
                  Image.asset(
                    team.logo,
                    width: 40,
                    height: 40,
                  ),
                  const Gap(
                    12.0,
                  ),
                  Text(team.name), // 팀명
                ],
              ),
              onTap: () {
                // 팀 선택 시 TeamProvider에 팀 저장하고 상세 페이지로 이동
                Provider.of<TeamProvider>(context, listen: false)
                    .selectTeam(team);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TeamScreen(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
