import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'package:frontend/providers/team_provider.dart';

class TeamHeader extends StatelessWidget {
  const TeamHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final team = Provider.of<TeamProvider>(context).selectedTeam;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      decoration: BoxDecoration(
        color: team != null
            ? Color(int.parse('0xFF${team.color.substring(1)}'))
            : Colors.transparent,
      ),
      child: Row(
        children: [
          team != null
              ? Image.asset(
                  team.logo,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                )
              : const Icon(
                  Icons.cancel_outlined,
                  size: 40,
                  color: Colors.grey,
                ),
          const Gap(12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                team != null ? team.name : '알 수 없음',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                team != null ? team.country : '알 수 없음',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
