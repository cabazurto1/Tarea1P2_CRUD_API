// widgets/digimon_card.dart
import 'package:flutter/material.dart';
import '../model/digimon_model.dart';

class DigimonCard extends StatelessWidget {
  final Digimon digimon;

  DigimonCard({required this.digimon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: digimon.img.isNotEmpty
            ? Image.network(
          digimon.img,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error, color: Colors.red);
          },
        )
            : Icon(Icons.image, color: Colors.grey),
        title: Text(digimon.name),
        subtitle: Text('Level: ${digimon.level}'),
      ),
    );
  }
}
