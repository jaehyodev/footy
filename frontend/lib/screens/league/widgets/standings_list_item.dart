import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import 'package:frontend/models/standing.dart';

class StandingsListItem extends StatelessWidget {
  final Standing standing;

  const StandingsListItem({super.key, required this.standing});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 1)
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 순위
          SizedBox(
            width: 24,
            child: Text(
              '${standing.position}',
              textAlign: TextAlign.start,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          const Gap(10),

          // 팀 아이콘
          Image.network(standing.teamLogo, width: 30, height: 30),
          const Gap(10),

          // 팀 이름 (왼쪽 정렬)
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft, // 왼쪽 정렬
              child:
                  Text(standing.teamName, style: const TextStyle(fontSize: 16)),
            ),
          ),

          // 승점
          SizedBox(
            width: 30,
            child: Text(
              '${standing.points}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),

          const Gap(5),

          // 경기수
          SizedBox(
            width: 30,
            child: Text(
              '${standing.playedGames}',
              textAlign: TextAlign.center, // 우측 정렬
              style: const TextStyle(color: Colors.grey),
            ),
          ),

          const Gap(5),

          // 승
          SizedBox(
            width: 20,
            child: Text(
              '${standing.won}',
              textAlign: TextAlign.center, // 우측 정렬
              style: const TextStyle(color: Colors.grey),
            ),
          ),

          const SizedBox(width: 5),

          // 무
          SizedBox(
            width: 20,
            child: Text(
              '${standing.draw}',
              textAlign: TextAlign.center, // 우측 정렬
              style: const TextStyle(color: Colors.grey),
            ),
          ),

          const SizedBox(width: 5),

          // 패
          SizedBox(
            width: 20,
            child: Text(
              '${standing.lost}',
              textAlign: TextAlign.center, // 우측 정렬
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
