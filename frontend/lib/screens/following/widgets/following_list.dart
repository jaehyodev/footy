import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'package:frontend/data/constants.dart';
import 'package:frontend/providers/following_provider.dart';

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
          List<String> teamList = followingProvider.followingTeams.toList();
          final teamName = teamList[index];

          // 팀 객체를 얻기 위한 방법 (예시로 `Constants.teams`에서 찾는 방법)
          final team =
              Constants.teams.firstWhere((team) => team.name == teamName);

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
                        followingProvider.toggleFollow(team.name); // 팀 삭제 처리
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
            ),
          );
        },
      ),
    );
  }
}
