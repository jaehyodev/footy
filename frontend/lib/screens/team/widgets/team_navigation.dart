import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'package:frontend/providers/team_provider.dart';

class TeamNavigation extends StatefulWidget {
  const TeamNavigation({super.key});

  @override
  State<TeamNavigation> createState() => _TeamNavigationState();
}

class _TeamNavigationState extends State<TeamNavigation> {
  @override
  Widget build(BuildContext context) {
    final team = Provider.of<TeamProvider>(context).selectedTeam;

    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            decoration: BoxDecoration(
              color: team != null
                  ? Color(int.parse('0xFF${team.color.substring(1)}'))
                  : Colors.transparent,
            ),
            child: Row(
              children: [
                _buildNavButton(context, 0, '스쿼드'),
                const Gap(24),
                _buildNavButton(context, 1, '경기'),
                const Gap(24),
                _buildNavButton(context, 2, '통계'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavButton(BuildContext context, int index, String text) {
    return GestureDetector(
      onTap: () {
        Provider.of<TeamProvider>(context, listen: false)
            .setSelectedIndex(index);
      },
      child: Text(
        text,
        style: TextStyle(
          color: Provider.of<TeamProvider>(context).selectedIndex == index
              ? Colors.white
              : Colors.white70,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
