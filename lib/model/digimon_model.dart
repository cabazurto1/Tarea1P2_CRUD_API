class Digimon {
  final String name;
  final String img;
  final String level;

  Digimon({
    required this.name,
    required this.img,
    required this.level,
  });

  factory Digimon.fromJson(Map<String, dynamic> json) {
    return Digimon(
      name: json['name'] ?? 'Unknown',
      img: json['img'] ?? '',
      level: json['level'] ?? 'Unknown',
    );
  }
}