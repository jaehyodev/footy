class PlayerInKorean {
  final String id;
  final String name;
  final String uniformNumber;
  final String position;
  final String countryName;
  final String countryCode;
  final bool captain;
  final bool viceCaptain;

  PlayerInKorean({
    required this.id,
    required this.name,
    required this.uniformNumber,
    required this.position,
    required this.countryName,
    required this.countryCode,
    required this.captain,
    required this.viceCaptain,
  });

  // JSON에서 Player 객체로 변환
  factory PlayerInKorean.fromJson(Map<String, dynamic> json) {
    return PlayerInKorean(
      id: json['id'],
      name: json['name'],
      uniformNumber: json['uniformNumber'],
      position: json['position'],
      countryName: json['countryName'],
      countryCode: json['countryCode'],
      captain: json['captain'],
      viceCaptain: json['viceCaptain'],
    );
  }

  // fromJsonList 메소드 (여러 명의 Player 객체를 생성)
  static List<PlayerInKorean> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PlayerInKorean.fromJson(json)).toList();
  }

  // Player 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'uniformNumber': uniformNumber,
      'position': position,
      'countryName': countryName,
      'countryCode': countryCode,
      'captain': captain,
      'viceCaptain': viceCaptain,
    };
  }
}
