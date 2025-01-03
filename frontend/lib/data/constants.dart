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
    Team(
      id: 33,
      tla: 'MNU',
      name: '맨체스터 유나이티드',
      shortName: '맨유',
      logo: 'assets/icons/teams/Man_United.png',
      country: '잉글랜드',
      color: '#DA020E',
    ),
    Team(
      id: 34,
      tla: 'NEW',
      name: '뉴캐슬 유나이티드',
      shortName: '뉴캐슬',
      logo: 'assets/icons/teams/Newcastle.png',
      country: '잉글랜드',
      color: '#3B3B3B',
    ),
    Team(
      id: 35,
      tla: 'BOU',
      name: 'AFC 본머스',
      shortName: '본머스',
      logo: 'assets/icons/teams/Bournemouth.png',
      country: '잉글랜드',
      color: '#D71C27',
    ),
    Team(
      id: 36,
      tla: 'FUL',
      name: '풀럼',
      shortName: '풀럼',
      logo: 'assets/icons/teams/Fulham.png',
      country: '잉글랜드',
      color: '#383D42',
    ),
    Team(
      id: 39,
      tla: 'WOL',
      name: '울버햄턴 원더러스',
      shortName: '울버햄턴',
      logo: 'assets/icons/teams/Wolves.png',
      country: '잉글랜드',
      color: '#FDB913',
    ),
    Team(
      id: 40,
      tla: 'LIV',
      name: '리버풀',
      shortName: '리버풀',
      logo: 'assets/icons/teams/Liverpool.png',
      country: '잉글랜드',
      color: '#D00027',
    ),
    Team(
      id: 41,
      tla: 'SOU',
      name: '사우샘프턴',
      shortName: '사우샘프턴',
      logo: 'assets/icons/teams/Southampton.png',
      country: '잉글랜드',
      color: '#ED1A3B',
    ),
    Team(
      id: 42,
      tla: 'ARS',
      name: '아스널',
      shortName: '아스널',
      logo: 'assets/icons/teams/Arsenal.png',
      country: '잉글랜드',
      color: '#E50007',
    ),
    Team(
      id: 45,
      tla: 'EVE',
      name: '에버턴',
      shortName: '에버턴',
      logo: 'assets/icons/teams/Everton.png',
      country: '잉글랜드',
      color: '#003399',
    ),
    Team(
      id: 46,
      tla: 'LEI',
      name: '레스터 시티',
      shortName: '레스터 시티',
      logo: 'assets/icons/teams/Leicester_City.png',
      country: '잉글랜드',
      color: '#0B56A4',
    ),
    Team(
      id: 47,
      tla: 'TOT',
      name: '토트넘 홋스퍼',
      shortName: '토트넘',
      logo: 'assets/icons/teams/Tottenham.png',
      country: '잉글랜드',
      color: '#0B1C56',
    ),
    Team(
      id: 48,
      tla: 'WHU',
      name: '웨스트햄 유나이티드',
      shortName: '웨스트햄',
      logo: 'assets/icons/teams/West_Ham.png',
      country: '잉글랜드',
      color: '#722233',
    ),
    Team(
      id: 49,
      tla: 'CHE',
      name: '첼시',
      shortName: '첼시',
      logo: 'assets/icons/teams/Chelsea.png',
      country: '잉글랜드',
      color: '#034694',
    ),
    Team(
      id: 50,
      tla: 'MCI',
      name: '맨체스터 시티',
      shortName: '맨시티',
      logo: 'assets/icons/teams/Man_City.png',
      country: '잉글랜드',
      color: '#98C5E9',
    ),
    Team(
      id: 51,
      tla: 'BHA',
      name: '브라이튼 앤 호브 알비온',
      shortName: '브라이튼',
      logo: 'assets/icons/teams/Brighton.png',
      country: '잉글랜드',
      color: '#0054A5',
    ),
    Team(
      id: 52,
      tla: 'CRY',
      name: '크리스탈 팰리스',
      shortName: '팰리스',
      logo: 'assets/icons/teams/Crystal_Palace.png',
      country: '잉글랜드',
      color: '#1B458F',
    ),
    Team(
      id: 55,
      tla: 'BRE',
      name: '브렌트퍼드',
      shortName: '브렌트퍼드',
      logo: 'assets/icons/teams/Brentford.png',
      country: '잉글랜드',
      color: '#E30613',
    ),
    Team(
      id: 57,
      tla: 'IPW',
      name: '입스위치 타운',
      shortName: '입스위치',
      logo: 'assets/icons/teams/Ipswich_Town.png',
      country: '잉글랜드',
      color: '#3B64A4',
    ),
    Team(
      id: 65,
      tla: 'NOT',
      name: '노팅엄 포레스트',
      shortName: '노팅엄',
      logo: 'assets/icons/teams/Nottm_Forest.png',
      country: '잉글랜드',
      color: '#CF102A',
    ),
    Team(
      id: 66,
      tla: 'AVL',
      name: '애스턴 빌라',
      shortName: '애스턴 빌라',
      logo: 'assets/icons/teams/Aston_Villa.png',
      country: '잉글랜드',
      color: '#480024',
    ),
    Team(
      id: 157,
      tla: 'BAY',
      name: '바이에른 뮌헨',
      shortName: '뮌헨',
      logo: 'assets/icons/teams/Bayern.png',
      country: '독일',
      color: '#9C1332',
    ),
  ];
}
