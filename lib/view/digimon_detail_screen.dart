// view/digimon_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/digimon_controller.dart';
import 'edit_digimon_screen.dart';

class DigimonDetailScreen extends StatelessWidget {
  final int index; // índice del digimon en la lista
  DigimonDetailScreen({required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DigimonController>(context);
    final digimon = controller.digimons[index];

    return Scaffold(
      appBar: AppBar(
        title: Text(digimon.name),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              controller.deleteDigimon(index);
              Navigator.pop(context); // Regresar a la lista
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            digimon.img.isNotEmpty
                ? Image.network(
              digimon.img,
              height: 200,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, color: Colors.red, size: 100);
              },
            )
                : Icon(Icons.image, size: 100, color: Colors.grey),
            SizedBox(height: 20),
            Text('Nombre: ${digimon.name}', style: TextStyle(fontSize: 20)),
            Text('Nivel: ${digimon.level}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de edición
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => EditDigimonScreen(index: index)),
                );
              },
              child: Text('Editar'),
            )
          ],
        ),
      ),
    );
  }
}
