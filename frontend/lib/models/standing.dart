class Standing {
  final int position;
  final String teamName;
  final String teamLogo;
  final int points;
  final int playedGames;
  final int won;
  final int draw;
  final int lost;
  final int goalsFor;
  final int goalsAgainst;
  final int goalDifference;
  final String form;

  Standing({
    required this.position,
    required this.teamName,
    required this.teamLogo,
    required this.points,
    required this.playedGames,
    required this.won,
    required this.draw,
    required this.lost,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.goalDifference,
    required this.form,
  });

  factory Standing.fromJson(Map<String, dynamic> json) {
    return Standing(
      position: json['position'],
      teamName: json['team']['shortName'],
      teamLogo: json['team']['crest'],
      points: json['points'],
      playedGames: json['playedGames'],
      won: json['won'],
      draw: json['draw'],
      lost: json['lost'],
      goalsFor: json['goalsFor'],
      goalsAgainst: json['goalsAgainst'],
      goalDifference: json['goalDifference'],
      form: json['form'],
    );
  }
}
