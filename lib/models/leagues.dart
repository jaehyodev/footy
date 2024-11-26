// lib/model/league.dart

class Leagues {
  final String name;
  final String code;

  Leagues({required this.name, required this.code});

  // 예시: 리그를 간단히 출력할 수 있도록 toString을 구현할 수도 있음
  // @override
  // String toString() => name;
}

List<Leagues> getLeagues() {
  return [
    Leagues(name: "전체", code: "ALL"),
    Leagues(name: "프리미어리그", code: "PL"),
    Leagues(name: "분데스리가", code: "BL1"),
    Leagues(name: "리그1", code: "FL1"),
    Leagues(name: "라리가", code: "LL"),
    Leagues(name: "세리에A", code: "SA"),
    Leagues(name: "챔피언스리그", code: "CL"),
    Leagues(name: "유로파리그", code: "EL"),
    Leagues(name: "EFL챔피언쉽", code: "ELC"),
  ];
}
