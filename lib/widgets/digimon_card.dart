// En lib/widgets/digimon_card.dart

import 'package:flutter/material.dart';
import '../model/digimon_model.dart';

class DigimonCard extends StatelessWidget {
  final Digimon digimon;

  DigimonCard({required this.digimon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(digimon.imageUrl), // Si Digimon tiene una imagen
        title: Text(digimon.name),
        subtitle: Text('Level: ${digimon.level}'),
      ),
    );
  }
}
