import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:gap/gap.dart';

class TeamPerson extends StatelessWidget {
  final dynamic player;

  const TeamPerson({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              'https://randomuser.me/api/portraits/lego/1.jpg', // 랜덤 이미지를 사용할 경우
            ),
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
                  CountryFlag.fromCountryCode(
                    player['countryCode'],
                    width: 30,
                    height: 20,
                  ),
                  const Gap(12),
                  Text(
                    player['countryName'],
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
