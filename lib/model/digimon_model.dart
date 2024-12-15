class Digimon {
  final int id;
  final String name;
  final String level;
  final String attribute;
  final String imageUrl;

  Digimon({
    required this.id,
    required this.name,
    required this.level,
    required this.attribute,
    required this.imageUrl,
  });

  factory Digimon.fromJson(Map<String, dynamic> json) {
    return Digimon(
      id: json['id'] != null ? json['id'] : 0,  // Maneja 'id' null
      name: json['name'] ?? 'Unknown',  // Usar 'Unknown' si 'name' es null
      level: json['level'] ?? 'Unknown',
      attribute: json['attribute'] ?? 'Unknown',
      imageUrl: json['images'] != null ? json['images']['icon'] : '',  // Verificar 'images'
    );
  }
}
