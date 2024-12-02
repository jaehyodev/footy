class Match {
  final String league;
  final String utcDate;
  final String homeTeam;
  final String awayTeam;
  final String status;
  final int fullTimeHomeScore;
  final int fullTimeAwayScore;

  const Match({
    required this.league,
    required this.utcDate,
    required this.homeTeam,
    required this.awayTeam,
    required this.status,
    required this.fullTimeHomeScore,
    required this.fullTimeAwayScore,
  });
}
