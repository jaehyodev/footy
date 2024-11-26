import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Provider를 사용하려면 이 import가 필요합니다.
import '../../../models/leagues.dart';
import '../theme/leagues_list_styles.dart'; // 스타일 가져오기
import '../../../providers/league_provider.dart'; // LeagueProvider 임포트

class LeaguesList extends StatefulWidget {
  const LeaguesList({
    super.key,
  });

  @override
  _LeaguesListState createState() => _LeaguesListState();
}

class _LeaguesListState extends State<LeaguesList> {
  int selectedIndex = 0; // 선택된 버튼 인덱스
  final List<Leagues> leagues = getLeagues(); // 사용할 리그 목록

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LeaguesListStyles.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: leagues.asMap().entries.map((entry) {
              int index = entry.key;
              Leagues league = entry.value;

              return Padding(
                padding: index == leagues.length - 1
                    ? EdgeInsets.zero // 마지막 버튼에는 여백을 주지 않음
                    : const EdgeInsets.only(
                        right:
                            4.0), // 그 외 버튼에는 오른쪽 여백을 줌튼 사이에 간격을 두기 위해 right padding만 추가
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedIndex = index; // 선택된 인덱스를 업데이트
                    });
                    context.read<LeagueProvider>().updateLeague(
                          index,
                          league.name,
                          league.code,
                        );
                  },
                  style: index == selectedIndex
                      ? LeaguesListStyles.selectedButtonStyle // 선택된 버튼 스타일
                      : LeaguesListStyles.defaultButtonStyle, // 기본 버튼 스타일
                  child: Text(
                    league.name, // 리그 이름 출력
                    style: index == selectedIndex
                        ? LeaguesListStyles.selectedTextStyle // 선택된 텍스트 스타일
                        : LeaguesListStyles.defaultTextStyle, // 기본 텍스트 스타일
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
