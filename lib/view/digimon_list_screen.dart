// view/digimon_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/digimon_controller.dart';
import 'digimon_detail_screen.dart';
import 'add_digimon_screen.dart';

class DigimonListScreen extends StatefulWidget {
  @override
  _DigimonListScreenState createState() => _DigimonListScreenState();
}

class _DigimonListScreenState extends State<DigimonListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DigimonController>(context, listen: false).loadDigimons();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DigimonController>(context);
    final digimons = controller.digimons;

    return Scaffold(
      appBar: AppBar(title: Text('Digimon List')),
      body: digimons.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: digimons.length,
        itemBuilder: (context, index) {
          final digimon = digimons[index];
          return ListTile(
            leading: digimon.img.isNotEmpty
                ? Image.network(
              digimon.img,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, color: Colors.red);
              },
            )
                : Icon(Icons.image, color: Colors.grey),
            title: Text(digimon.name),
            subtitle: Text('Level: ${digimon.level}'),
            onTap: () {
              // Navegar a detalles
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DigimonDetailScreen(index: index),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Navegar a la pantalla para agregar un nuevo Digimon
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddDigimonScreen()),
          );
        },
      ),
    );
  }
}
