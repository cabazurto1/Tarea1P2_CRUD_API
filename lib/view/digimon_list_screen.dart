import 'package:flutter/material.dart';
import '../controller/digimon_controller.dart';
import '../widgets/digimon_card.dart';
import 'package:provider/provider.dart';
import '../model/digimon_model.dart';
import '../services/digimon_api_service.dart';

class DigimonListScreen extends StatefulWidget {
  @override
  _DigimonListScreenState createState() => _DigimonListScreenState();
}

class _DigimonListScreenState extends State<DigimonListScreen> {
  final DigimonService digimonService = DigimonService();
  List<Digimon> digimons = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    _fetchDigimons();
  }

  Future<void> _fetchDigimons() async {
    try {
      final fetchedDigimons = await digimonService.fetchDigimons(page: page);
      setState(() {
        digimons.addAll(fetchedDigimons);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load digimons: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Digimon List')),
      body: ListView.builder(
        itemCount: digimons.length,
        itemBuilder: (context, index) {
          final digimon = digimons[index];
          return ListTile(
            leading: digimon.imageUrl != null && digimon.imageUrl.isNotEmpty
                ? Image.network(
              digimon.imageUrl,
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
            onTap: () {
              // Navigate to details screen
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Navigate to add screen
        },
      ),
    );
  }
}
