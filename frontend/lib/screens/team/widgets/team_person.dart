import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:frontend/providers/team_provider.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class TeamPerson extends StatelessWidget {
  final dynamic player;

  const TeamPerson({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    // 'photo'가 있으면 해당 'photo'를 사용하고, 없으면 기본 레고 이미지 사용
    final photoUrl = (player['photo'] != null && player['photo'].isNotEmpty)
        ? player['photo']
        : 'https://randomuser.me/api/portraits/lego/1.jpg';

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(photoUrl),
          ),
          const Gap(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                player['name'],
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Gap(8),
              Row(
                children: [
                  player['countryCode'] != null
                      ? CountryFlag.fromCountryCode(
                          player['countryCode'],
                          width: 30,
                          height: 20,
                        )
                      : const Icon(Icons.flag,
                          size: 30), // countryCode가 null일 경우 대체 아이콘 표시
                  const Gap(12),
                  Text(
                    player['countryName'] ??
                        'Unknown', // countryName이 null일 경우 'Unknown'으로 처리
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
