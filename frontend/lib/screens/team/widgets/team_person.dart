import 'package:flutter/material.dart';

class TeamPerson extends StatelessWidget {
  final dynamic player;

  const TeamPerson({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              'https://randomuser.me/api/portraits/lego/1.jpg', // 랜덤 이미지를 사용할 경우
            ), // 동그란 얼굴 이미지
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                player['name'], // 이름
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Icon(
                    Icons.flag, // 나라 아이콘
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    player['country'], // 나라 이름
                    style: TextStyle(
                        fontSize: 14, color: Colors.grey[600]), // 회색 텍스트
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
