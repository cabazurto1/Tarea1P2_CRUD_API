import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/digimon_controller.dart';
import 'view/digimon_list_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DigimonController()),
      ],
      child: MaterialApp(
        title: 'Digimon CRUD',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: DigimonListScreen(),
      ),
    );
  }
}
