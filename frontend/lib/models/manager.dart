class Manager {
  final int id;
  final String name;
  final String photo;

  Manager({
    required this.id,
    required this.name,
    required this.photo,
  });

  factory Manager.fromJson(Map<String, dynamic> json) {
    return Manager(
      id: json['id'],
      name: json['name'],
      photo: json['photo'] ?? 'https://randomuser.me/api/portraits/lego/1.jpg',
    );
  }
}
