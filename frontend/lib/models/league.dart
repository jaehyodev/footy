class League {
  final String name;
  final String code;

  const League({required this.name, required this.code});
}

const List<League> leagues = [
  League(name: '전체', code: 'ALL'),
  League(name: '프리미어리그', code: 'PL'),
  League(name: '분데스리가', code: 'BL1'),
  League(name: '리그1', code: 'FL1'),
  League(name: '라리가', code: 'LL'),
  League(name: '세리에A', code: 'SA'),
  League(name: '챔피언스리그', code: 'CL'),
  League(name: '유로파리그', code: 'EL'),
  League(name: 'EFL챔피언쉽', code: 'ELC'),
];
