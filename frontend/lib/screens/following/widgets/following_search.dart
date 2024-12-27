import 'package:flutter/material.dart';
import 'package:frontend/providers/following_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gap/gap.dart';

import 'package:frontend/data/constants.dart';
import 'package:frontend/models/team.dart';

class FollowingSearch extends StatefulWidget {
  const FollowingSearch({super.key});

  @override
  FollowingSearchState createState() => FollowingSearchState();
}

class FollowingSearchState extends State<FollowingSearch> {
  // 검색어 컨트롤러
  final TextEditingController _searchController = TextEditingController();

  // 필터링된 팀 목록
  List<Team> filteredTeams = Constants.teams;

  // 검색어 변경 시 필터링 업데이트
  void _filterTeams(String query) {
    setState(() {
      filteredTeams = Constants.teams
          .where(
              (team) => team.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // 엑스 버튼 클릭 시 검색어 초기화
  void _clearSearch() {
    _searchController.clear();
    _filterTeams(""); // 필터링을 기본 상태로 되돌림
  }

  @override
  Widget build(BuildContext context) {
    final followingProvider = Provider.of<FollowingProvider>(context);

    return Column(
      children: [
        // Row 안에 뒤로가기 버튼과 검색 필드 배치
        Padding(
          padding: const EdgeInsets.only(
              top: 16.0, right: 8.0, left: 8.0, bottom: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start, // 왼쪽 정렬
            children: [
              // 뒤로 가기 버튼
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop(); // 뒤로 가기
                },
                padding: EdgeInsets.zero,
              ),
              // 검색 입력창
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterTeams, // 검색어가 변경될 때마다 필터링
                  decoration: InputDecoration(
                    hintText: '팀 검색',
                    border: InputBorder.none,
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: _clearSearch, // 엑스 버튼 클릭 시 텍스트 초기화
                          )
                        : null, // 텍스트가 없으면 엑스 버튼 비활성화
                  ),
                ),
              ),
            ],
          ),
        ),
        // 필터된 팀 목록을 표시하는 ListView
        Expanded(
          child: ListView.builder(
            itemCount: filteredTeams.length, // 필터된 팀 리스트의 개수
            itemBuilder: (context, index) {
              final team = filteredTeams[index];
              final isFollowing =
                  followingProvider.followingTeams.contains(team.name);

              return ListTile(
                leading: Image.asset(
                  team.logo,
                  width: 40,
                  height: 40,
                ),
                title: Text(team.name), // 팀명
                trailing: IconButton(
                  icon: Icon(
                    isFollowing ? Icons.favorite : Icons.favorite_border,
                    color: isFollowing ? Colors.red : null,
                  ),
                  onPressed: () {
                    followingProvider.toggleFollow(team.name);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
