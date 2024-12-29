class Player {
  final int id;
  final String name;
  final int age;
  final int number;
  final String position;
  final String photo;

  Player({
    required this.id,
    required this.name,
    required this.age,
    required this.number,
    required this.position,
    required this.photo,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      number: json['number'],
      position: json['position'],
      photo: json['photo'],
    );
  }
}

class Team {
  final int id;
  final String name;
  final String logo;

  Team({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
    );
  }
}

class SquadResponse {
  final Team team;
  final List<Player> players;

  SquadResponse({required this.team, required this.players});

  factory SquadResponse.fromJson(Map<String, dynamic> json) {
    var playersList = (json['players'] as List)
        .map((playerJson) => Player.fromJson(playerJson))
        .toList();

    return SquadResponse(
      team: Team.fromJson(json['team']),
      players: playersList,
    );
  }
}
