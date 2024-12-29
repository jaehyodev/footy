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
      id: json['id'] ?? 0, // 'id'가 null일 경우 기본값 0으로 처리
      name: json['name'] ?? 'Unknown', // 'name'이 null일 경우 기본값
      age: json['age'] ?? 0, // 'age'가 null일 경우 기본값
      number: json['number'] ?? 0, // 'number'가 null일 경우 기본값
      position: json['position'] ?? 'Unknown', // 'position'이 null일 경우 기본값
      photo: json['photo'] ?? '', // 'photo'가 null일 경우 기본값
    );
  }

  @override
  String toString() {
    return 'Player{id: $id, name: $name, age: $age, number: $number, position: $position, photo: $photo}';
  }
}

class Team2 {
  final int id;
  final String name;
  final String logo;

  Team2({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory Team2.fromJson(Map<String, dynamic> json) {
    return Team2(
      id: json['id'] ?? 0, // 'id'가 null일 경우 기본값 0으로 처리
      name: json['name'] ?? 'Unknown', // 'name'이 null일 경우 기본값
      logo: json['logo'] ?? '', // 'logo'가 null일 경우 기본값
    );
  }

  @override
  String toString() {
    return 'Team2{id: $id, name: $name, logo: $logo}';
  }
}

class SquadResponse {
  final Team2 team;
  final List<Player> players;

  SquadResponse({required this.team, required this.players});

  factory SquadResponse.fromJson(Map<String, dynamic> json) {
    var playersList = (json['players'] as List<dynamic>?)?.map((playerJson) {
          return Player.fromJson(playerJson as Map<String, dynamic>);
        }).toList() ??
        []; // null 처리

    var teamData = json['team'] != null
        ? Team2.fromJson(json['team'])
        : Team2(id: 0, name: 'Unknown', logo: ''); // 'team'이 null인 경우 기본 값 처리

    return SquadResponse(
      team: teamData,
      players: playersList,
    );
  }

  @override
  String toString() {
    return 'SquadResponse{team: $team, players: $players}';
  }
}
