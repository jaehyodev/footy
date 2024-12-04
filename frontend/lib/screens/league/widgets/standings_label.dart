import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

class StandingsLabel extends StatelessWidget {
  const StandingsLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 순위
          const SizedBox(
            width: 30,
            child: Text(
              '순위',
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.grey),
            ),
          ),

          // 팀 이름
          // 라벨 없이 남은 공간을 채우는 부분
          Expanded(
            child: Container(),
          ),

          // 승점
          const SizedBox(
            width: 30,
            child: Text(
              '승점',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),

          const Gap(5),

          const SizedBox(
            width: 30,
            child: Text(
              '경기',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),

          const Gap(5),

          const SizedBox(
            width: 20,
            child: Text(
              '승',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),

          const Gap(5),

          const SizedBox(
            width: 20,
            child: Text(
              '무',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),

          const Gap(5),

          const SizedBox(
            width: 20,
            child: Text(
              '패',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
