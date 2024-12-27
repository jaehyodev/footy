import 'package:frontend/models/team.dart';

class Constants {
  static const String appName = 'Footy';

  static const List<String> appBarTitles = [
    'Footy',
    '뉴스',
    '리그',
    '팔로잉',
    '설정',
  ];

  static final List<Team> teams = [
    Team(name: 'Arsenal', logo: 'assets/icons/teams/Arsenal.png'),
    Team(name: 'Aston Villa', logo: 'assets/icons/teams/Aston_Villa.png'),
    Team(name: 'Bayern', logo: 'assets/icons/teams/Bayern.png'),
    Team(name: 'Bournemouth', logo: 'assets/icons/teams/Bournemouth.png'),
    Team(name: 'Brentford', logo: 'assets/icons/teams/Brentford.png'),
    Team(name: 'Brighton', logo: 'assets/icons/teams/Brighton.png'),
    Team(name: 'Chelsea', logo: 'assets/icons/teams/Chelsea.png'),
    Team(name: 'Crystal Palace', logo: 'assets/icons/teams/Crystal_Palace.png'),
    Team(name: 'Everton', logo: 'assets/icons/teams/Everton.png'),
    Team(name: 'Fulham', logo: 'assets/icons/teams/Fulham.png'),
    Team(name: 'Ipswich Town', logo: 'assets/icons/teams/Ipswich_Town.png'),
    Team(name: 'Leicester City', logo: 'assets/icons/teams/Leicester_City.png'),
    Team(name: 'Liverpool', logo: 'assets/icons/teams/Liverpool.png'),
    Team(name: 'Man City', logo: 'assets/icons/teams/Man_City.png'),
    Team(name: 'Man United', logo: 'assets/icons/teams/Man_United.png'),
    Team(name: 'Newcastle', logo: 'assets/icons/teams/Newcastle.png'),
    Team(name: 'Nottm Forest', logo: 'assets/icons/teams/Nottm_Forest.png'),
    Team(name: 'Southampton', logo: 'assets/icons/teams/Southampton.png'),
    Team(name: 'Tottenham', logo: 'assets/icons/teams/Tottenham.png'),
    Team(name: 'West Ham', logo: 'assets/icons/teams/West_Ham.png'),
    Team(name: 'Wolves', logo: 'assets/icons/teams/Wolves.png'),
  ];
}
