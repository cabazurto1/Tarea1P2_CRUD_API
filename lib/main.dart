// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/digimon_controller.dart';
import 'view/digimon_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => DigimonController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digimon CRUD',
      home: DigimonListScreen(),
    );
  }
}
