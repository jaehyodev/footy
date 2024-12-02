import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:frontend/utils/time_utils.dart';

class MatchesListItem extends StatelessWidget {
  final Map<String, dynamic> match;

  const MatchesListItem({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final matchTime = TimeUtils.formattedKoreanTime(
        TimeUtils.convertToKoreanTime(DateTime.parse(match['utcDate'])));
    final homeTeam = match['homeTeam'];
    final awayTeam = match['awayTeam'];
    final homeTeamIcon = match['homeTeam']['crest'];
    final awayTeamIcon = match['awayTeam']['crest'];
    final homeScore = match['score']['fullTime']['home'] ?? '';
    final awayScore = match['score']['fullTime']['away'] ?? '';
    final matchday = match['matchday'].toString();

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white, // 배경색
        borderRadius: BorderRadius.circular(12), // 둥근 모서리 12 -> 0
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(matchTime,
                  style: const TextStyle(fontSize: 12, color: Colors.black)),
              const Gap(
                16.0,
              ),
              Text("${matchday}R",
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const Gap(
            12.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 왼쪽: 경기시간, 홈팀 정보
              Row(
                children: [
                  Image.network(
                    homeTeamIcon,
                    width: 24, // 아이콘 크기 설정
                    height: 24, // 아이콘 크기 설정
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 24, // 아이콘 크기 설정
                      );
                    },
                  ), // 홈팀 아이콘
                  const Gap(
                    8.0,
                  ),
                  Text(homeTeam['name'],
                      style: const TextStyle(
                          fontFamily: 'SpoqaHanSansNeo',
                          fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text(homeScore == null ? '' : '$homeScore'),
                ],
              ),
              const Gap(
                8.0,
              ),
              // 아래: 어웨이팀 정보
              Row(
                children: [
                  Image.network(
                    awayTeamIcon,
                    width: 24, // 아이콘 크기 설정
                    height: 24, // 아이콘 크기 설정
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 24, // 아이콘 크기 설정
                      );
                    },
                  ), // 홈팀 아이콘
                  const Gap(
                    8.0,
                  ),
                  Text(awayTeam['name'],
                      style: const TextStyle(
                          fontFamily: 'SpoqaHanSansNeo',
                          fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text(awayScore == null ? '' : '$awayScore'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
